# frozen_string_literal: true

# Force all gems to use Ruby platform
# Bundler.settings.set_local('force_ruby_platform', true)

source 'https://rubygems.org'

ruby '~> 3.3' # Make sure that this matches .ruby-version file.

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.2'
# Use Puma as the app server
gem 'puma', '~> 6.x'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Compile complex front-end assets.
gem 'sprockets'
gem 'sprockets-rails'
# See https://github.com/rails/jsbundling-rails/
gem 'jsbundling-rails'
# See https://github.com/rails/cssbundling-rails/
gem 'cssbundling-rails'
# SCSS compilation support
gem 'sassc-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use third party sign on authenticate users
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'psych', '< 4.0.0'

# Use Haml instead of erb
# https://haml.info/tutorial.html
gem 'haml-rails'

# A nice HTTP client library
gem 'faraday'

# Google API
gem 'google-api-client', '~> 0.34'

# Geocodio API and related dependencies
gem 'geocodio-gem'
gem 'geocodio'

gem 'faraday-follow_redirects'
gem 'json'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

gem 'csv'
# Even though this gem is only required for rake tasks, heroku needs it to run
# pre-receive rake tasks hook so it is included for production environment.
gem 'rubyzip'

gem 'date_validator'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows]

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'debug'

  # Handy text output of DB schema
  gem 'annotate'

  # Run the Procfile.dev with `foreman s -f Procfile.dev` or `bin/dev`
  gem 'foreman'

  # Testing utilities
  gem 'cucumber-rails', '>= 3.0.0', require: false
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem "selenium-webdriver"

  # Linting Utilities
  # Run 'bundle exec pronto' to check code with linters
  # Pronto runs linters only on changed code (based on git diff)
  # However, it is not as easy to install on some environments
  gem 'pronto', require: false
  gem 'pronto-rubocop', require: false
  gem "pronto-haml", require: false

  # Run 'bundle exec rubocop' to delint your code
  # Run 'bundle exec rubocop -a' to autocorrect line errors.
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem "rubocop-performance", require: false
  gem 'haml_lint', require: false

  # Accessibility Testing
  gem 'axe-core-rspec'
  gem 'axe-core-cucumber'

  gem 'sqlite3'

  # Guard Plugins
  gem 'guard'
  gem 'guard-cucumber', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false

  # Report coverage.
  gem 'codecov', require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem "simplecov-json", require: false
  gem 'simplecov_lcov_formatter', require: false
end

group :development do
  # Open files from save_and_open page
  gem 'launchy'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.5.0'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'

  # Add model annotations above files
  gem "annotaterb"
end

group :production, :staging do
  # Use postgresql as the database for Active Record in production (Heroku)
  gem 'pg'
end
