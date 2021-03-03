source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
# PG as databse
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'
gem 'sass-rails', '>= 5.0.8'
gem 'jquery-rails', '>= 4.3.1'
gem 'font-awesome-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Pagination
gem 'will_paginate'
gem 'will_paginate-bootstrap4'

# ANNOTATION
gem 'annotate', '>= 2.7.2'

# URL FRIENDLY
gem 'friendly_id', '~> 5.1.0'

# SECURITY
gem 'devise', '>= 4.7.0'

## EXCEPTION NOTFIFICATION
gem 'exception_notification', '>= 4.4.0'

# IMAGE UPLOAD
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem "fog-aws"

# SITEMAP GENERATOR
gem 'sitemap_generator'

# API Scrapping
gem 'rest-client'

# JS UPDATE
gem 'best_in_place', '~> 3.0.3'

# Geolocation
gem 'geocoder'

# Scrapping
gem 'mechanize'

# ENV Variables
gem 'figaro'


group :development, :test do
  # Debug
  gem 'pry-byebug'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  # WHY ?
  gem 'selenium-webdriver'
end

group :development do
  # Mailing emulation
  gem 'mailcatcher'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.5.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
