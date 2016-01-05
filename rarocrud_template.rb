path = "/Users/diegolima/Documents/rarocrud_template"
generate "controller", "home index"
remove_file "app/assets/javascripts/application.js"
remove_file "app/assets/stylesheets/application.css"
remove_file "app/controllers/application_controller.rb"
remove_file "app/views/layouts/application.html.erb"
remove_file "db/seeds.rb"
remove_file "config/initializers/inflections.rb"
remove_file "config/initializers/assets.rb"
remove_file "config/routes.rb"

directory "#{path}/app/", "app"
directory "#{path}/vendor/", "vendor"
directory "#{path}/db/", "db"
directory "#{path}/config/", "config"

inject_into_file 'config/application.rb', :after => 
"config.i18n.default_locale = :de\n" do 
  <<-RUBY
    config.time_zone = 'Brasilia'

    config.i18n.default_locale = 'pt-BR'
    I18n.enforce_available_locales = false
    I18n.default_locale = 'pt-BR'
    
    config.to_prepare do
      Devise::SessionsController.layout "login"
      Devise::RegistrationsController.layout "signup"
      Devise::PasswordsController.layout "forgot_password"
    end
    config.active_record.observers = :reference_observer
RUBY
end

append_file 'Gemfile' do 
  <<-RUBY

gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass', '3.3.0.0'
gem 'font-awesome-rails', '4.3.0.0'
gem 'toastr-rails'

#permission
gem 'cancancan'
gem 'devise'
gem 'rails-observers'
gem 'wiselinks'

#worker
gem 'sidekiq'

#rarocrud
gem 'templus_models', "1.5.10"
gem 'carrierwave'
gem 'rmagick'
gem 'summernote-rails'

# Use Unicorn as the app server
gem 'unicorn'
gem 'capistrano-unicorn'

#Capistrano
gem 'capistrano'
gem 'rvm-capistrano',  require: false

#authenticators
#gem 'omniauth', '>= 1.0.0'
#gem 'omniauth-linkedin-oauth2'
#gem 'omniauth-facebook'

  
RUBY
end