## Overview

This is a simple Twitter clone. Users can sign up and post 'peeps'. Users can log in and log out. Passwords are encrypted with BCrypt. This was a week 4 weekend challenge at Makers.

![alt text](/public/images/app_homepage.png)

## How to Run This App

Clone the repo. From the terminal, run ```bundle install``` in the project directory. Create databases needed (see Databases Migration below). Use ```rackup config.ru``` to run the web app locally, then connect to the specified port from your local browser.

To run tests, run ```rspec``` from the terminal in the root project directory.

## User Stories

```
STRAIGHT UP

As a Maker
So that I can let people know what I am doing  
I want to post a message (peep) to chitter

As a maker
So that I can see what others are saying  
I want to see all peeps in reverse chronological order

As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made

As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter

HARDER

As a Maker
So that only I can post messages on Chitter as me
I want to log in to Chitter

As a Maker
So that I can avoid others posting messages on Chitter as me
I want to log out of Chitter
```

## Database Migration

The app requires a development and a test database. To set up the databases
using Rake, from command line run ```rake setup```
Alternatively, to create these manually, connect to psql and then run these commands:
```
CREATE DATABASE chitter;
```
and
```
CREATE DATABASE chitter_test;
```
Then for each database run commands listed in db folder.


## Technologies Used

This is a Sinatra-based web app. Tests are set up using rspec and Capybara. PostgreSQL database connections are set up using PG. Passwords are encrypted using BCrypt.
