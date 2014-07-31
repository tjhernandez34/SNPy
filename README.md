SNPy: Look at Your Genome
====

[![Coverage Status](https://img.shields.io/coveralls/ozayyad/SNPy.svg)](https://coveralls.io/r/ozayyad/SNPy)

[![Build Status](https://travis-ci.org/ozayyad/SNPy.svg?branch=nataliemac81)](https://travis-ci.org/ozayyad/SNPy)




DESCRIPTION

GETTING APP RUNNING

- git clone 
- bundle install
- rake db:create
- rake db:migrate
- rake fetch_markers


GEMS USED

-# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use postgresql as the database for Active Record
gem 'redis'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'titleize'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'textacular'
# bundle exec rake doc:rails generates the API under doc/api.
group :doc do
  gem 'sdoc', '~> 0.4.0'
end

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring


group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
  gem 'spring'
end

group :test do
  gem 'minitest'
  gem 'shoulda-matchers'
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor', '0.0.2'
end

gem 'nokogiri'


gem 'byebug'
## authentication
gem 'monban'
gem 'monban-generators'

## genome uploader
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'fog'
gem 'figaro'
gem 'aws-sdk'

gem 'coveralls', require: false

gem 'aws-sdk-core'
gem 'delayed_job_active_record'

AUTHORS
