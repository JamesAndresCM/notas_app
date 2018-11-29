# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#Rename Project
* rails g rename:into NewName
* change title app in application-helper (title default)

#Generate ssl certificate to devise omniauth
* `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`
* run rails with ssl `rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'` 
* add Your Keys (facebook and gmail) create file config/application.yml and add env variables
