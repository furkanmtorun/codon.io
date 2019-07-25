from flask import Flask, render_template, url_for

app = Flask(__name__)

# Index Page
@app.route("/")
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

# codon.io
if __name__ == "__main__":
    app.run(debug=True)