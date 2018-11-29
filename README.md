# Rails base
## Rename Project
* rails g rename:into NewName
* change title app in application-helper (title default)

## Generate ssl certificate to devise omniauth
* `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`
* run rails with ssl `rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'` 
* Add Your Keys (facebook and gmail) create file config/application.yml for env variables
* redis-server && bundle exec sidekiq -C config/sidekiq.yml
