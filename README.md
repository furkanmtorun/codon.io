# codon.io

## What is codon.io?

**codon.io** is a new platform that enables people who code to ask questions and get the answers in real-time and freely.

> **Do not let a single code line make you crazy!**

> **Important Note:** This project is not affiliated with the domain name "codon.io".

## Motivation behind the project

We as undergrad students from departments of genetics and electronics always face a number of problem while coding and waiting a rapid answer for the questions and would like to offer a solution for that problem. 

## What technologies did we use?

 - Front-end: HTML, CSS ([MaterializeCss](https://materializecss.com)), jQuery
 - Back-end: [Flask](https://palletsprojects.com/p/flask/) (Python), [Socket.io](https://socket.io)
 - DB: MySQL
 -  Others: Git

## How to build that web site in my computer? (locally)

You can either download our project files directly as "**.zip**" format above or clone the project folder through Git with the command below.

`git clone https://github.com/furkanmtorun/codon.io.git`
  
 Due to the fact that we have used several Python packages, you need to install them if you not already. To make this job easier, we have listed the necessary packages in the file named "**requirements.txt**" in the project folder and you can directly install all the necessary packages at once:

To change the directory in order to access the project folder, type this command:

`cd codon.io`

Then,

`pip install -r requirements.txt`

> If you face a problem during the installation of **mysqlclient** package, you can check that answer out: [https://stackoverflow.com/a/51164104](https://stackoverflow.com/a/51164104)


Then, if you did not install earlier, you have to install a local web server to upload project database schema and make the connection available. In this regard, you may download and install [XAMPP](https://www.apachefriends.org/tr/index.html) (free and easy-to-use) according to your operation system.  

After the successful installation, you need to make our db schema available. To be able to do that, you can import "**db_schema.sql**" SQL file into your localhost database named "**codon.io**" via **phpMyAdmin** on **localhost/phpmyadmin**. 

> If you are not familiar with these processes, you can follow these instructions: 
> + How to install XAMPP for Windows? [https://www.wikihow.com/Install-XAMPP-for-Windows](https://www.wikihow.com/Install-XAMPP-for-Windows)
> + How to import a file into the database? [https://thakshashila.com/how-to-import-database-in-localhost-xampp/](https://thakshashila.com/how-to-import-database-in-localhost-xampp/)


> Please, be aware that, you need to type your database name as
> "**codon.io**" or you need to alter it from "**configs.yml**" file
> changing "**MYSQL_DB**" variable.

Then, you are almost ready to go!

## Set your configs

We gather all the required configs / variables into a one file named "**configs.yml**".
Here is what you need to consider:

 - Please, be aware that you set your db connections correctly:
	 - MySQL Username: `MYSQL_USER : "root"`
	 - MySQL Password:  `MYSQL_PASSWORD : ""`
	 - MySQL DB Name: `MYSQL_DB : "codon.io"`

- After these settings are done, you have to set the mail server configs:
	- Make available your gmail for the project from the link https://myaccount.google.com/lesssecureapps
	- Gmail Account: `MAIL_USERNAME: "YourGmailAccount@gmail.com"`
	- Gmail Password:  `MAIL_PASSWORD: "YourPassword"`

> For "Forgot Password" system, we've used Gmail SMTP Server, therefore you need to type your gmail account.

## Time to run!
Finally, we are ready to make our project available! 
Just open the project folder in the terminal or any IDE as you preffered and type this magic command:

`python codon.io`


*Python 3 has been used in the process of development and is recommended. If you have installed both Python 2 and Python 3, you need to specifiy it in the command as* `python3 codon.io`.

**The project is ready on your local device from that link:** 
`127.0.0.1:5000`

## Contribution to the project
We would be very happy to see your feedbacks and contributions on the project. 

**If you would like to join, just let us know :)**

Furkan Torun : [furkanmtorun@gmail.com](mailto:furkanmtorun@gmail.com)

Bilal Kabas : [bilalkabas@icloud.com](mailto:bilalkabas@icloud.com)

## Screenshots

**Profile Page**
![Profile Page](https://user-images.githubusercontent.com/49681382/65806668-568c7b00-e193-11e9-9033-451508182330.png)

**Settings Page**
![Settings Page](https://user-images.githubusercontent.com/49681382/65806696-7459e000-e193-11e9-8232-98cdd9dcbc40.png)

**Home Page**
![Home Page](https://user-images.githubusercontent.com/49681382/65806732-a2d7bb00-e193-11e9-96e3-e600877fdf7c.png)

**Chat Window**
![Chat Window](https://user-images.githubusercontent.com/49681382/65806707-850a5600-e193-11e9-9549-6fb772e52933.png)


