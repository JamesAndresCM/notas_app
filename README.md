# Rails base
## Rename Project
* rails g rename:into NewName
* change title app in application-helper (title default)
* change title [mailer](https://github.com/JamesAndresCM/base_rails_5/blob/ec116a3b08753836bc6770c0cc363321ff9603ac/app/views/mail_form/contact.erb#L1)
* change message and add email in headers `app/models/main.rb`
## Generate ssl certificate to devise omniauth
* `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`
* run rails with ssl `rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'` 
* Add Your Keys (facebook and gmail) create file config/application.yml for env variables
* redis-server && bundle exec sidekiq -C config/sidekiq.yml
