source 'https://rubygems.org'
ruby '2.1.4'

# Standard Rails gems
gem 'rails', '4.1.7'
gem 'sass-rails', '4.0.3'
gem 'uglifier', '2.5.3'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.1.2'
gem 'turbolinks', '2.5.1'
gem 'jbuilder', '2.2.4'
gem 'bcrypt', '3.1.9'

# Kaminari: https://github.com/amatsuda/kaminari
gem 'kaminari', '0.16.1'

# Friendly_id: https://github.com/norman/friendly_id
gem 'friendly_id', '5.0.4'

# Font-awesome: https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '4.2.2'

# Bootstrap 3: https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass', '3.3.0.1'

# Figaro: https://github.com/laserlemon/figaro
group :development, :test do
  gem 'figaro', '1.0.0'
  gem 'rspec-rails'
  gem 'database_cleaner', git: 'git@github.com:bmabey/database_cleaner.git'
end

group :development do
  gem 'guard-rails'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-livereload', require: false
  gem 'terminal-notifier-guard'
end

# PostgreSQL
gem 'pg'

# Devise: https://github.com/plataformatec/devise
gem 'devise', '3.4.1'

# Redcarpet: https://github.com/vmg/redcarpet
gem 'redcarpet', '3.2.0'

# Rails 12factor for Heroku: https://github.com/heroku/rails_12factor
group :production do
  gem 'rails_12factor'
end

# Unicorn: http://unicorn.bogomips.org
group :production do
  gem 'unicorn'
end

group :test do
  gem 'factory_girl_rails'
end

gem 'smarter_csv'