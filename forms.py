from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField, TextField
from wtforms.validators import DataRequired, Length, Email, EqualTo

class RegistrationForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired(), Length(min=3, max=100)])
    confirm_password = PasswordField('Confirm Password', validators=[DataRequired(), Length(min=3, max=100), EqualTo('password', message= 'Password do not match!')])
    #submit = SubmitField('Register')

class LoginForm(FlaskForm):
    username = StringField('Username or Email', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember = BooleanField('Remember me')
    #submit = SubmitField('Login')

class SettingsForm(FlaskForm):
    #name = StringField('Name', validators=[DataRequired(), Length(min=2, max=20)])
    #gender = StringField('Gender', validators=[DataRequired(), Length(min=2, max=10)])
    avatar_link = StringField('Profile Img Link', validators=[DataRequired(), Length(min=2, max=120)])
    #about = TextField('About me', validators=[DataRequired(), Length(min=2, max=100)])
    #old_password = PasswordField('Old Password', validators=[DataRequired()])
    #password = PasswordField('New Password', validators=[DataRequired()])
    #confirm_password = PasswordField('Confirm New Password', validators=[DataRequired(), Length(min=3, max=100), EqualTo('password', message= 'Password do not match!')])
    #submit = SubmitField('Login')