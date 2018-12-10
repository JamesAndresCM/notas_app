# Note App

## Instrucciones
* Cambiar mensaje y agregar email para formulario [headers](https://github.com/JamesAndresCM/notas_app/blob/master/app/models/main.rb#L12)
* bundle install
* rake db:create
* rake db:migrate
* rake db:seed

## Crear archivo para establecer las keys de facebook oauth y el email

* archivo config/application.yml
````
development:
  FACEBOOK_APP_ID: "KEY_ID"
  FACEBOOK_APP_SECRET: "....."
  HOST: "localhost:3000"
  EMAIL_USER: "EMAIL"
  EMAIL_PASSWORD: "PASSWORD"
````
  

## Generar certificado SSl para development
* `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`
* run rails with ssl `rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'` 
* Add Your Keys (facebook and gmail) create file config/application.yml for env variables
* redis-server && bundle exec sidekiq -C config/sidekiq.yml

## User Admin por defecto
* user : admin@domain.com
* password : 123456

# Iniciar redis, ejecutar sidekiq e iniciar el proyecto
* redis-server
* bundle exec sidekiq -C config/sidekiq.yml
* rails server
