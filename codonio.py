from flask import Flask, render_template, url_for, redirect, flash
app = Flask(__name__)

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

# Logout Page
@app.route("/logout")
def logout():
    flash("You logged out!", msg_type_to_color['success'])
    return redirect(url_for("home"))

# codon.io
if __name__ == "__main__":
    app.secret_key = "qYqDyVT^!2%qUsY=A@qb"
    app.run(debug=True)