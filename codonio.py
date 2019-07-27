from flask import Flask, render_template, url_for, redirect, flash
from forms import RegistrationForm, LoginForm
from flask_mysqldb import MySQL
from passlib.hash import sha256_crypt

app = Flask(__name__)
app.config["SECRET_KEY"] = "157a6ca4d2e34d77a949d61f8724d8e878e51e66b2babe2adc"

# Config MySQL
#______________________________________________________________________
# This part will be changed using YAML.
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "codon.io"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
#_______________________________________________________________________
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
        result = cur.execute("SELECT * FROM users WHERE username = %s or email=%s", (form.username.data, form.username.data))
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
    form = LoginForm()
    if form.validate_on_submit():

        #MySQL Integration
        cur = mysql.connection.cursor()
        result = cur.execute("SELECT * FROM users WHERE username = %s or email=%s", (form.username.data, form.username.data))
        if result > 0:
            data = cur.fetchone()
            password = data["password"]            
            if sha256_crypt.verify(form.password.data, password):
                flash("Welcome @" + form.username.data + "!", msg_type_to_color["success"])
                return redirect(url_for("home"))
            else:
                flash("Invalid login!", msg_type_to_color["error"])
        else:
            flash("Username or email not found!", msg_type_to_color["error"])

    return render_template("login.html", form=form, title="Login")



# Home Page
@app.route("/home")
def home():
    return render_template("home.html")



# Profil Page
@app.route("/profile")
def profil():
    return render_template("profile.html", title="Profile")



# Profil Page
@app.route("/settings")
def settings():
    return render_template("settings.html", title="Settings")



# Chat Page
@app.route("/chat")
def chat():
    return render_template("chat.html", title="Chat")



# Logout Page
@app.route("/logout")
def logout():
    flash("You logged out!", msg_type_to_color['success'])
    return redirect(url_for("home"))



# codon.io
if __name__ == "__main__":
    app.run(debug=True)