from flask import Flask, render_template, url_for, redirect, flash, session
from forms import RegistrationForm, LoginForm, ProfileForm, ChangePasswordForm
from flask_mysqldb import MySQL
from passlib.hash import sha256_crypt
from datetime import timedelta
from functools import wraps
import yaml

app = Flask(__name__)

# Set the configs
with open("./configs.yml") as f:
    configs = yaml.load(f)
app.config["SECRET_KEY"] = configs["SECRET_KEY"]
app.config['PERMANENT_SESSION_LIFETIME'] =  timedelta(minutes=configs["PERMANENT_SESSION_LIFETIME"])
# Config MySQL Connection
app.config["MYSQL_HOST"] = configs["MYSQL_HOST"]
app.config["MYSQL_USER"] = configs["MYSQL_USER"]
app.config["MYSQL_PASSWORD"] = configs["MYSQL_PASSWORD"]
app.config["MYSQL_DB"] = configs["MYSQL_DB"]
app.config["MYSQL_CURSORCLASS"] = configs["MYSQL_CURSORCLASS"]
mysql = MySQL(app)

# Conversion from message type to color
msg_type_to_color = {
    'success': 'green lighten-1',
    'error': 'red',
    'warning': 'orange',
    'announcement': 'purple lighten-1'
}

# Index Page
@app.route("/")
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
                    session['username'] = form.username.data
                    # Get avatar_link
                    session['avatar_link'] = data["avatar_link"]
                    flash("Welcome @" + form.username.data + "!", msg_type_to_color["success"])
                    return redirect(url_for("home"))
                else:
                    flash("Invalid login!", msg_type_to_color["error"])
            else:
                flash("Username or email not found!", msg_type_to_color["error"])

        return render_template("login.html", form=form, title="Login")



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


# Home Page
@app.route("/home")
@is_logged_in
def home():
    return render_template("home.html")



# Profil Page
@app.route("/profile/<string:username>")
@is_logged_in
def profile(username):
    # Retrieve user information
    cur = mysql.connection.cursor()
    result = cur.execute("SELECT * FROM users WHERE username = %s", [username])
    if result > 0:
        profile_info = cur.fetchone()
        return render_template("profile.html", title="Profile", profile_info=profile_info)
    else:
        flash("There is no such a user", msg_type_to_color["error"])
        return redirect(url_for("home"))
    


# Settings Page
@app.route("/settings", methods=["GET", "POST"])
@is_logged_in
def settings():
    # MySQL Integration
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE username = %s", [(session['username'])])
    profile_info = cur.fetchone()

    profileForm = ProfileForm()
    changePasswordForm = ChangePasswordForm()

    if profileForm.validate_on_submit():
        # MySQL Integration
        cur = mysql.connection.cursor()
        # Check the presnece of the username and email in the table
        cur.execute("UPDATE users SET name= % s, about = %s, avatar_link = %s, gender = %s WHERE username = %s", (profileForm.name.data, profileForm.about.data, profileForm.avatar_link.data, profileForm.gender.data, session["username"]))
        mysql.connection.commit() 
        cur.close()
        # Message and redirection into login
        flash("Account settings were changed successfuly.", msg_type_to_color["success"])
        return redirect("profile/" + session["username"])

    if changePasswordForm.validate_on_submit():
        #MySQL Integration
        cur = mysql.connection.cursor()
        result = cur.execute("SELECT * FROM users WHERE username = %s", [(session['username'])])
        if result > 0:
            data = cur.fetchone()
            password = data["password"]            
            if sha256_crypt.verify(changePasswordForm.old_password.data, password):
                cur.execute("UPDATE users SET password = %s WHERE username = %s", (sha256_crypt.hash(str(changePasswordForm.password.data)), session["username"]))
                mysql.connection.commit()
                cur.close()
                # Message and redirection into login
                flash("Account settings were changed successfuly.", msg_type_to_color["success"])
                return redirect("profile/" + session["username"])
            else:
                flash("Invalid Old Password!", msg_type_to_color["error"])
            
    return render_template("settings.html", profileForm=profileForm, 
                            changePasswordForm=changePasswordForm, title="Settings", profile_info=profile_info)



# Chat Page
@app.route("/chat")
@is_logged_in
def chat():
    return render_template("chat.html", title="Chat")



# Logout Page
@app.route("/logout")
@is_logged_in
def logout():
    session.clear()
    flash("You logged out!", msg_type_to_color['success'])
    return redirect(url_for("index"))



# codon.io
if __name__ == "__main__":
    app.run(debug=True)