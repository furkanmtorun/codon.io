from flask import Flask, render_template, url_for, redirect, flash
from forms import RegistrationForm, LoginForm

app = Flask(__name__)
app.config["SECRET_KEY"] = "157a6ca4d2e34d77a949d61f8724d8e878e51e66b2babe2adc"

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

# Home Page
@app.route("/home")
#@is_logged_in
def home():
    return render_template("home.html")

# Profil Page
@app.route("/profile")
def profil():
    return render_template("profile.html")

# Profil Page
@app.route("/settings")
def settings():
    return render_template("settings.html")

# Chat Page
@app.route("/chat")
def chat():
    return render_template("chat.html")

# Logout Page
@app.route("/logout")
def logout():
    flash("You logged out!", msg_type_to_color['success'])
    return redirect(url_for("home"))

# codon.io
if __name__ == "__main__":
    app.run(debug=True)