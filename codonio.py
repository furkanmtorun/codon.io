from flask import Flask, render_template, url_for, redirect, flash, session, jsonify, request
from forms import RegistrationForm, LoginForm, ProfileForm, ChangePasswordForm, ForgotPasswordForm
from flask_mysqldb import MySQL
from passlib.hash import sha256_crypt
from datetime import timedelta, datetime
from functools import wraps
import yaml
# Necessary packages for Socket.io
from flask_session import Session
from flask_socketio import SocketIO, send, emit, join_room, leave_room, close_room
import uuid, json
from bson import json_util
# Necessary packages for Background scheduling
import schedule
import time
# Email
from flask_mail import Mail, Message

app = Flask(__name__)
app.debug = True

# Set the configs from configs.yml
with open("./configs.yml") as f:
    configs = yaml.load(f, Loader=yaml.SafeLoader)
app.config["SECRET_KEY"] = configs["SECRET_KEY"]
app.config['PERMANENT_SESSION_LIFETIME'] =  timedelta(minutes=configs["PERMANENT_SESSION_LIFETIME"])
# Config MySQL Connection
app.config["MYSQL_HOST"] = configs["MYSQL_HOST"]
app.config["MYSQL_USER"] = configs["MYSQL_USER"]
app.config["MYSQL_PASSWORD"] = configs["MYSQL_PASSWORD"]
app.config["MYSQL_DB"] = configs["MYSQL_DB"]
app.config["MYSQL_CURSORCLASS"] = configs["MYSQL_CURSORCLASS"]
mysql = MySQL(app)
# Config Email Server
# Please, check whether you can use your gmail account in less secure apps
app.config['MAIL_SERVER'] = configs["MAIL_SERVER"]
app.config['MAIL_PORT'] = configs["MAIL_PORT"]
app.config['MAIL_USERNAME'] = configs["MAIL_USERNAME"]
app.config['MAIL_PASSWORD'] = configs["MAIL_PASSWORD"]
app.config['MAIL_USE_TLS'] = configs["MAIL_USE_TLS"]
app.config['MAIL_USE_SSL'] = configs["MAIL_USE_SSL"]
app.config['MAIL_DEFAULT_SENDER'] = configs["MAIL_DEFAULT_SENDER"]
mail = Mail(app)

# Conversion from message type to the color
msg_type_to_color = {
    'success': 'green lighten-1',
    'error': 'red',
    'warning': 'orange',
    'announcement': 'purple lighten-1'
}


# Redirect to the index page
@app.route("/")
def redirect_home():
    return redirect(url_for("index"))

# Index Page
@app.route("/index")
def index():
    return render_template("index.html")



# Register Page
@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        # MySQL Integration
        cur = mysql.connection.cursor()
        # Check the presnece of the username and email in the table
        result = cur.execute("SELECT * FROM users WHERE username = %s or email = %s", (form.username.data, form.email.data))
        if result > 0:
            flash("Username or email is already taken! Choose another one.", msg_type_to_color["error"])
        else:
            cur.execute("INSERT INTO users (username, email, password) VALUES (%s, %s, %s)", (form.username.data, form.email.data, sha256_crypt.hash(str(form.password.data))))
            mysql.connection.commit() 
            cur.close()
            # Message and redirection into login
            flash("Registration was completed successfuly.", msg_type_to_color["success"])
            return redirect(url_for("login"))        
    return render_template("register.html", form=form, title="Register")



# Login Page
@app.route("/login", methods=["GET", "POST"])
def login():
    try:
        if session["username"]:
            return redirect(url_for("home"))
    except KeyError:
        form = LoginForm()
        if form.validate_on_submit():
            # Session timeout
            session.permanent = True
            #MySQL Integration
            cur = mysql.connection.cursor()
            result = cur.execute("SELECT * FROM users WHERE username = %s OR email = %s", (form.username.data, form.username.data))
            if result > 0:
                data = cur.fetchone()
                password = data["password"]            
                if sha256_crypt.verify(form.password.data, password):
                    session['logged_in'] = True
                    # Get user information
                    session['username'] = data["username"]
                    session['user_id'] = data["id"]
                    session['avatar_link'] = data["avatar_link"]
                    session['conversation_id'] = 0
                    # Set room id
                    session['room'] = str(uuid.uuid4()) + '-' + form.username.data
                    flash("Welcome @" + form.username.data + "!", msg_type_to_color["success"])
                    cur.execute("INSERT INTO user_logs (user_id,ip) VALUES (%s, %s)", [session['user_id'], request.remote_addr])
                    mysql.connection.commit()
                    return redirect(url_for("home"))
                else:
                    flash("Invalid login!", msg_type_to_color["error"])
            else:
                flash("Username or email not found!", msg_type_to_color["error"])
        cur.close()
        return render_template("login.html", form=form, title="Login")


# Forgot Password
@app.route("/forgot_password", methods=["GET", "POST"])
def forgot_password():
    form = ForgotPasswordForm()
    if form.validate_on_submit():
        #MySQL Integration
        cur = mysql.connection.cursor()
        result = cur.execute("SELECT password FROM users WHERE email = %s", [form.email.data])
        if result > 0:
            data = cur.fetchone()
            password = data["password"]
            msg = Message('Reset my codon.io password!', recipients = [form.email.data])
            msg.body = "Here is your password: " + password 
            mail.send(msg)
            flash("We sent the required information to your email adress!", msg_type_to_color["success"])
        else:
            flash("Email not found!", msg_type_to_color["error"])
    cur.close()
    return render_template("forgot_password.html", form=form)


# Logging
def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash("Unauthorized, please log in", msg_type_to_color["error"])
			return redirect(url_for("login"))
	return wrap



# Logout Page
@app.route("/logout")
@is_logged_in
def logout():
    session.clear()
    flash("You logged out!", msg_type_to_color['success'])
    return redirect(url_for("index"))



# Home Page
@app.route("/home")
@is_logged_in
def home():
    cur = mysql.connection.cursor()
    cur.execute("SELECT username, name, avatar_link, about, room_id, GROUP_CONCAT(skill_list.skill_name) as skill_name FROM users INNER JOIN skills ON users.id=skills.user_id INNER JOIN skill_list ON skills.skill_id=skill_list.id WHERE room_id != '0' GROUP BY username")
    available_users = cur.fetchall()
    cur.close()
    return render_template("home.html",  users=available_users)



# Profil Page
@app.route("/profile/<string:username>", methods=["GET", "POST"])
@is_logged_in
def profile(username):
    # Retrieve user information
    cur = mysql.connection.cursor()
    result = cur.execute("SELECT * FROM users WHERE username = %s", [username])
    if result > 0:
        profile_info = cur.fetchone()                                                                                                       
        cur.execute("SELECT skill_name, skill_logo FROM skills INNER JOIN users ON users.username=%s INNER JOIN skill_list ON skills.skill_id=skill_list.id WHERE skills.user_id=users.id", [username])
        skills_info = cur.fetchall()

        # User statistics
        number_of_question = cur.execute("SELECT conversation_logs.id FROM conversation_logs INNER JOIN users ON users.username = %s WHERE questioner_id = users.id", [username])
        number_of_answer = cur.execute("SELECT conversation_logs.id FROM conversation_logs INNER JOIN users ON users.username = %s WHERE respondent_id = users.id", [username])
        cur.execute("SELECT IFNULL(SUM(rating_types.value), 0) AS point FROM rating_logs INNER JOIN users ON users.username=%s INNER JOIN rating_types ON rating_logs.rate_type_id=rating_types.id WHERE rated_about=users.id", [username])
        point = cur.fetchone()
        number_of_abusement = cur.execute("SELECT message_id,messages.user_id FROM `abuse_allegations` INNER JOIN users ON users.username=%s INNER JOIN messages ON message_id=messages.id WHERE user_id=users.id", [username])
        user_stats = (number_of_question, number_of_answer, point['point'], number_of_abusement)
        cur.close()
        return render_template("profile.html", title="Profile", profile_info=profile_info, skills_info=skills_info, user_stats=user_stats)
    else:
        flash("There is no such a user", msg_type_to_color["error"])
        cur.close()
        return redirect(url_for("home"))
    


# Get the whole list of skills for auto-complete in the profile page
@app.route("/get-skills")
def get_skills():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM skill_list")
    skills = cur.fetchall()
    cur.close()
    return jsonify(skills) 



# Give a feedback
@app.route("/give-feedback", methods=["GET", "POST"])
def give_feedback():
    cur = mysql.connection.cursor()
    feedback = request.get_json()
    cur.execute("INSERT INTO feedbacks (reported_by, feedback) VALUES (%s, %s)", (session['user_id'], feedback))
    mysql.connection.commit()
    cur.close()
    return jsonify()



# Add new skills
@app.route("/update_skills", methods=["GET", "POST"])
def update_skills():
    cur = mysql.connection.cursor()
    skills = request.get_json()
    for skill in skills:
        cur.execute("SELECT * FROM skill_list WHERE skill_name = %s", [skill])
        skill = cur.fetchone()
        skill_id = skill['id']
        cur.execute("INSERT INTO skills (user_id, skill_id) VALUES (%s, %s)", (session['user_id'], skill_id))
        mysql.connection.commit()
    cur.close()
    return jsonify()

    

# Remove skills
@app.route("/remove_skills", methods=["GET", "POST"])
def remove_skills():
    cur = mysql.connection.cursor()
    skill = request.get_json()
    cur.execute("SELECT * FROM skill_list WHERE skill_name = %s", [skill])
    skill = cur.fetchone()
    skill_id = skill['id']
    cur.execute("DELETE FROM skills WHERE user_id = %s AND skill_id = %s", (session['user_id'], skill_id))
    mysql.connection.commit()
    cur.close()
    return jsonify()



# Settings Page
@app.route("/settings", methods=["GET", "POST"])
@is_logged_in
def settings():
    # MySQL Integration
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE username = %s", [(session['username'])])
    profile_info = cur.fetchone()
    cur.execute("SELECT * FROM user_logs WHERE user_id = %s ORDER BY id DESC", [(session['user_id'])])
    user_logs_info = cur.fetchall()

    profileForm = ProfileForm()
    changePasswordForm = ChangePasswordForm()

    if profileForm.validate_on_submit():
        # MySQL Integration
        cur = mysql.connection.cursor()
        # Check the presnece of the username and email in the table
        cur.execute("UPDATE users SET name= % s, about = %s, avatar_link = %s, gender = %s WHERE username = %s", 
                    (profileForm.name.data, profileForm.about.data, profileForm.avatar_link.data, profileForm.gender.data, session["username"]))
        mysql.connection.commit() 
        cur.close()
        session["avatar_link"] = profileForm.avatar_link.data
        # Message and redirection into login
        flash("Account settings were changed successfuly.", msg_type_to_color["success"])
        return redirect(url_for("settings"))

    if changePasswordForm.validate_on_submit():
        #MySQL Integration
        cur = mysql.connection.cursor()
        result = cur.execute("SELECT * FROM users WHERE username = %s", [(session['username'])])
        if result > 0:
            data = cur.fetchone()
            password = data["password"]            
            if sha256_crypt.verify(changePasswordForm.old_password.data, password):
                cur.execute("UPDATE users SET password = %s WHERE username = %s", 
                            (sha256_crypt.hash(str(changePasswordForm.password.data)), session["username"]))
                mysql.connection.commit()
                cur.close()
                # Message and redirection into login
                flash("Account settings were changed successfuly.", msg_type_to_color["success"])
                return redirect(url_for("settings"))
            else:
                flash("Invalid Old Password!", msg_type_to_color["error"])
                return redirect(url_for("settings"))
            
    return render_template("settings.html", profileForm=profileForm, changePasswordForm=changePasswordForm, 
                            title="Settings", profile_info=profile_info, user_logs_info=user_logs_info)




# Delete account
@app.route("/delete_account", methods=["GET", "POST"])
@is_logged_in
def delete_account():
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM users WHERE id = %s", [session['user_id']])
    mysql.connection.commit()
    cur.close()
    session.clear()
    flash("Your account has been deleted. We've started to miss you now!", msg_type_to_color["warning"])
    return redirect(url_for("index"))



# 404 Error Page
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404



# CHAT WINDOW
# Get the rate types for rating answers
@app.route("/get-rate-types")
def get_rate_types():
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, name FROM rating_types")
    rating_types = cur.fetchall()
    cur.close()
    return jsonify(rating_types)

# Rate the answer
@app.route("/rate-answer", methods=["GET", "POST"])
def rate_answer():
    cur = mysql.connection.cursor()
    data = request.get_json()
    # Get the respondent id
    cur.execute("SELECT respondent_id FROM conversation_logs WHERE id = %s", [data['conversation_id']])
    rated_about = cur.fetchone()
    # Insert the rate into the DB
    cur.execute("INSERT INTO rating_logs (rated_by, rated_about, rate_type_id) VALUES (%s, %s, %s)", (session['user_id'], rated_about['respondent_id'], data['rate_type_id']))
    mysql.connection.commit()
    cur.close()
    return jsonify() 

# Report abuse
@app.route("/report_abuse", methods=["GET", "POST"])
def report_abuse():
    cur = mysql.connection.cursor()
    muid = request.get_json()
    cur.execute("SELECT id FROM messages WHERE mes_uniq_id= %s", [muid])
    mes_info = cur.fetchone()
    message_id = mes_info['id']
    cur.execute("INSERT INTO abuse_allegations (message_id, complained_by) VALUES (%s, %s)", (message_id, session['user_id']))
    mysql.connection.commit()
    cur.close()
    return jsonify()


# Socket.io
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)
socketio = SocketIO(app, manage_sessions=False)


# Get users 
def update_available_users():
    cur = mysql.connection.cursor()
    cur.execute("SELECT username, name, avatar_link, about, room_id, GROUP_CONCAT(skill_list.skill_name) as skills FROM users INNER JOIN skills ON users.id=skills.user_id INNER JOIN skill_list ON skills.skill_id=skill_list.id WHERE status_id = 1 GROUP BY username")    
    available_users = cur.fetchall()
    available_users = json.dumps(available_users, default=json_util.default)
    emit('update available users', available_users, broadcast=True)
    cur.close()


def change_user_status(username, status, room_id):
    cur = mysql.connection.cursor()
    cur.execute("UPDATE users SET status_id = %s, room_id = %s WHERE username = %s",(status, room_id, [username]))
    mysql.connection.commit()
    cur.close()


# Join the personal room / It is mandatory that user will join the same room for every single request
@socketio.on('join', namespace='/session')
@is_logged_in
def on_join():
    join_room(session['room'])
    cur = mysql.connection.cursor()
    user = cur.execute("SELECT * FROM users WHERE username = %s", [session['username']])
    user = cur.fetchone()
    cur.close()
    if user['status_id'] != '1':
        change_user_status(session['username'], 1, session['room'])
        update_available_users()


# Send chat request to the respondent
@socketio.on('send request', namespace='/session')
@is_logged_in
def on_request(data):
    # Get respondent's room_id
    room = data['room']
    # Get questioner's name
    questioner = session['username']
    # Get questioner's avatar_link    
    avatar_link = session['avatar_link']
    # Get questioner's bio    
    cur = mysql.connection.cursor()
    cur.execute("SELECT about FROM users WHERE username = %s",[questioner])
    about = cur.fetchone()
    about = about['about']
    # Close questioner's current room
    close_room(session['room'])
    # Find the respondent
    cur.execute("SELECT * FROM users WHERE room_id = %s", [data['room']])
    respondent = cur.fetchone()
    # Generate a new room id for private chat
    room_id = str(uuid.uuid4()) + questioner + respondent['username']
    # Make questioner join the chat room
    join_room(room_id)
    # Change questioner's status to 'asking' : '3'
    change_user_status(questioner, 3, room_id)
    # Change respondent's status to 'answering' : '4'
    change_user_status(respondent['username'], 4, 0)
    # Send the chat request to respondent
    emit('incoming request', {'questioner': questioner, 'room': room_id, 'avatar_link': avatar_link, 'about' : about, 'question': data['question'], 'skills': data['skills']}, room=room, include_self=False)
    # To send messages, send the chat room's id to questioner
    emit('receive room id', {'room': room_id}, room=room_id, broadcast=False)
    # Update available users
    update_available_users()
    cur.close()

# Respondent joins the chat room
@socketio.on('join chat room', namespace='/session')
@is_logged_in
def join_chat_room(data):
    room = data['room']
    cur = mysql.connection.cursor()
    # Get questioner's id
    cur.execute("SELECT * FROM users WHERE room_id = %s", [data['room']])
    questionerId = cur.fetchone()
    questionerId = questionerId['id']
    # Save the conversation in DB
    cur.execute("INSERT INTO conversation_logs(topic, questioner_id, respondent_id, room_id) VALUES(%s, %s, %s, %s)", (data['topic'], questionerId, session['user_id'], room))
    mysql.connection.commit()
    # Get the conversation id as the last row's id
    conversation_id = cur.lastrowid
    session['conversation_id'] = conversation_id
    # Save skills in DB
    for skill in data['skills']:
        #  Get skill ids
        cur.execute("SELECT * FROM skill_list WHERE skill_name = %s", [skill])
        skill_id = cur.fetchone()
        skill_id = skill_id['id']
        # Save the skill into conversation_skills
        cur.execute("INSERT INTO conversation_skills(conversation_id, skill_id) VALUES(%s, %s)", (conversation_id, skill_id))
        mysql.connection.commit()
    cur.close()    
    join_room(room)
    emit('respondent joined', {'respondent': session['username'], 'conversation_id': conversation_id}, room=room, include_self=False)


# Send messages
@socketio.on('send message', namespace='/session')
@is_logged_in
def send_message(data):
    # Get the conversation id
    cur = mysql.connection.cursor()
    if session['conversation_id'] == 0:
        cur.execute("SELECT * FROM conversation_logs WHERE room_id = %s", [data['room']])
        room_id = cur.fetchone()
        room_id = room_id['room_id']
        if room_id == data['room']:
            conversation_id = data['conversation_id']
    else:
        conversation_id = session['conversation_id']
    # Save the message in DB
    message_id = str(uuid.uuid4()) + '_' + str(datetime.now().day) + str(datetime.now().month) + str(datetime.now().year)
    cur.execute("INSERT INTO messages(mes_uniq_id, user_id, conversation_id, message) VALUES(%s, %s, %s, %s)", 
                    (message_id, session['user_id'], conversation_id, data['message']))
    mysql.connection.commit()
    cur.close()
    emit('message', {'username': session['username'], 'avatar_link': session['avatar_link'], 'message_id': message_id, 'message': data['message']}, room=data['room'], include_self=False)


# Decline the chat request
@socketio.on('decline chat request', namespace='/session')
@is_logged_in
def decline_chat_request(data):
    session['room'] = str(uuid.uuid4()) + '-' + session['username']
    join_room(session['room'])
    # Change respondent's status to 'available' : '1' again
    change_user_status(session['username'], 1, session['room'])
    emit('request declined', {}, room=data['room'])
    update_available_users()


# Leave the chat
@socketio.on('leave chat', namespace='/session')
@is_logged_in
def leave_chat(data):
    emit('questioner ends chat', {'questioner': session['username']}, room=data['room'], include_self=False)
    leave_room(data['room'])
    session['room'] = str(uuid.uuid4()) + '-' + session['username']
    join_room(session['room'])  
    cur = mysql.connection.cursor()
    # Change user's status to 'available' : '1'  
    cur.execute("UPDATE users SET room_id = %s, status_id = %s WHERE username = %s",(session['room'], 1, session['username']))
    mysql.connection.commit()
    update_available_users()
    cur.close()


# Logout
@socketio.on('logout', namespace='/session')
@is_logged_in
def logout_socket(data):
    # Change user's status to 'unavailable' : '2'    
    change_user_status(session['username'], 2, 0)
    close_room(session['room'])
    update_available_users()
    return redirect(url_for('logout'))


# Get available coders
@socketio.on('get available coders', namespace='/session')
@is_logged_in
def get_available_coders():
    update_available_users()


# Finding out the bests of the week periodically
def ranking_system_week():
    # Parameters and variables
    now = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
    previous_week = (datetime.today() - timedelta(weeks=1)).strftime("%Y-%m-%d %H:%M:%S")
    cur = mysql.connection.cursor()
    week_rating_types = [1,2,3]
    
    # Determine the winners
    cur.execute("SELECT rated_about AS 'user_id', SUM(rating_types.value) AS 'score' FROM rating_logs INNER JOIN rating_types ON rating_logs.rate_type_id=rating_types.id " + 
                "WHERE rating_logs.created_at BETWEEN %s AND %s GROUP BY rated_about ORDER BY score DESC LIMIT 3", (previous_week, now))
    winners_of_the_week = cur.fetchall()
    uids_winners_of_the_week = [winner_week["user_id"] for winner_week in winners_of_the_week]
    
    # Upload the winners into the table
    for user_id_week, rating_type_week in zip(uids_winners_of_the_week, week_rating_types):
        cur.execute("INSERT INTO ranking_logs (user_id, ranking_type) VALUES (%s, %s)", (user_id_week, rating_type_week))
        mysql.connection.commit()
    cur.close()


# Finding out the bests of the month periodically
def ranking_system_month():
    # Parameters and variables
    now = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
    previous_month = (datetime.today() - timedelta(days=30)).strftime("%Y-%m-%d %H:%M:%S") # not certain but roughly a month
    cur = mysql.connection.cursor()
    month_rating_types = [4,5,6]
    
    # Determine the winners
    cur.execute("SELECT rated_about AS 'user_id', SUM(rating_types.value) AS 'score' FROM rating_logs INNER JOIN rating_types ON rating_logs.rate_type_id=rating_types.id " +
                "WHERE rating_logs.created_at BETWEEN %s AND %s GROUP BY rated_about ORDER BY score DESC LIMIT 3", (previous_month, now))
    winners_of_the_month = cur.fetchall()
    uids_winners_of_the_month = [winner_month["user_id"] for winner_month in winners_of_the_month]

    # Upload the winners into the table
    for user_id_month, rating_type_month in zip(uids_winners_of_the_month, month_rating_types):
        cur.execute("INSERT INTO ranking_logs (user_id, ranking_type) VALUES (%s, %s)", (user_id_month, rating_type_month))
        mysql.connection.commit()
    cur.close()


# Schedule ranking system periodically
schedule.every(7).days.do(ranking_system_week)
schedule.every(30).days.do(ranking_system_month)
    


# codon.io
if __name__ == "__main__":
    socketio.run(app)
    while True:
        schedule.run_pending()
