source 'https://rubygems.org'
ruby '2.1.4'

# Standard Rails gems
gem 'rails', '4.1.7'
gem 'sass-rails', '4.0.3'
gem 'uglifier', '2.5.3'
gem 'coffee-rails', '4.0.1'
gem 'jbuilder', '2.2.4'
gem 'bcrypt', '3.1.9'

# Kaminari: https://github.com/amatsuda/kaminari
gem 'kaminari', '0.16.1'

# Friendly_id: https://github.com/norman/friendly_id
gem 'friendly_id', '5.0.4'

# Font-awesome: https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '4.2.2'

# Figaro: https://github.com/laserlemon/figaro
group :development, :test do
  gem 'figaro', '1.0.0'
  gem 'rspec-rails'
  gem 'database_cleaner', git: 'git@github.com:bmabey/database_cleaner.git'
end

group :development do
  gem 'foreman'
  gem 'guard-rails'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-livereload', require: false
  gem 'terminal-notifier-guard'
  gem 'guard-foreman'
end

# PostgreSQL
gem 'pg'

# Delayed_Jobs for Rails 3.0.0+
gem 'delayed_job_active_record'
gem 'scheduled_job'

# Devise: https://github.com/plataformatec/devise
gem 'omniauth'
gem 'devise_token_auth', git: "https://github.com/ddmck/devise_token_auth.git"
gem 'omniauth-facebook' #for facebook login

# Redcarpet: https://github.com/vmg/redcarpet
gem 'redcarpet', '3.2.0'

# Rails 12factor for Heroku: https://github.com/heroku/rails_12factor
group :production do
  gem 'rails_12factor'
end

gem 'foundation-rails'

gem 'angularjs-rails'

# Unicorn: http://unicorn.bogomips.org

gem 'puma'

group :test do
  gem 'factory_girl_rails'
end

gem 'smarter_csv'

gem 'will_paginate', '~> 3.0'

# for import delays
gem 'resque'

# For cross origin requests
gem 'rack-cors', require: 'rack/cors'

# For search
gem 'textacular', '~> 3.0'

gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'bonsai-elasticsearch-rails'

#for grabbing CSV datafeeds
gem 'httparty'

#for unzipping files
gem 'rubyzip'

# for scaling workers
gem "hirefire-resource"

# for prerender of dynamic pages
gem 'prerender_rails'

# For analytics
gem 'newrelic_rpm'

# For XML importer
gem 'nokogiri'
gem 'saxerator'

# For Stripe
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# For Email
gem 'mailgunner'

#for YO
gem 'yo4r'
