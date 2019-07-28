from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField, TextAreaField, RadioField
from wtforms.validators import DataRequired, Length, Email, EqualTo

class RegistrationForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired(), Length(min=3, max=100)])
    confirm_password = PasswordField('Confirm Password', validators=[DataRequired(), Length(min=3, max=100), EqualTo('password', message= 'Password do not match!')])

class LoginForm(FlaskForm):
    username = StringField('Username or Email', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember = BooleanField('Remember me')

class ProfileForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired(), Length(min=2, max=20)])
    gender = RadioField('Gender', choices = [('Female','Female'), ('Male','Male'), ('Do not prefer to say','Do not prefer to say')], validators=[DataRequired()])
    avatar_link = StringField('Profile Img Link', validators=[DataRequired(), Length(min=2, max=120)])
    about = TextAreaField('About me', validators=[DataRequired(), Length(min=1, max=100)])


class ChangePasswordForm(FlaskForm):
    old_password = PasswordField('Old Password', validators=[DataRequired()])
    password = PasswordField('New Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm New Password', validators=[DataRequired(), Length(min=3, max=100), EqualTo('password', message= 'Password do not match!')])