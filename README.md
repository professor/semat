== README



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




Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

## Installing
$ echo "RACK_ENV=development" >>.env
$ echo "PORT=3000" >> .env
foreman start

heroku run rake db:migrate --app semat
heroku run rake  semat:import_alpha_cards

rake assets:precompile RAILS_ENV=production

heroku pgbackups:capture --expire --app semat

heroku run rails console

 http://localhost:3000/api/v1/simple_alphas.json



## Setup
rails console
AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

## Great Tools
http://jsonlint.com/
Excellent Tutorial on Android and Rails: http://lucatironi.github.io/tutorial/2012/10/15/ruby_rails_android_app_authentication_devise_tutorial_part_one/


