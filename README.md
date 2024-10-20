requirement -
1) install python, mysql 
2) install virtualenv package on python

step 1 - import the sql file in mysql to create the fastbox database. file path( "../fastbox20.sql"). using mysql workbench -> login to root a/c -> server -> data import -> import from self-container file -> select file path from ... -> import process tab -> start import -> done ( all db file installed successfully)
step 2 - configure the settings.py file to connect with the database. 
file path ( "parselmanagementsystem/fastbox/settings.py" )
step 3 - configure the databases parameters (on line 80 ). set user and password according to your mysql username and password, make sure that the hostname is localhost in your mysql with port 3306.
step 4 -  when all the settings has been configred. open the command prompt and locate the folder "../parselManagementSystem/fastbox/ and make it the working director by using cd command.
step 5 - run this command to start the django project   python manage.py runserver
step 6 - it will start the django project and generate a url, copy the url and paste in the browser or hit Ctrl + click to open the link ( if using a IDE ).
step 7 - navigate and explore to know the features of the project.

Thank You, Happy coding :)  .





features:

email integration
payment gateway integration using razorpay API
dynamic price calculation using zipcodebase API
interative UI
Dashboard for customers, Dealers, and owner
