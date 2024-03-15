source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"

gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"

# gem "turbo-rails"
# gem "stimulus-rails"
gem "jbuilder"

gem 'active_storage-postgresql'

gem 'mail_form'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem "sassc-rails"

gem 'jquery-rails'
gem 'jquery-ui-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

gem "devise"
gem "autoprefixer-rails"
gem "font-awesome-sass", "~> 6.1"
gem "simple_form", github: "heartcombo/simple_form"
gem 'will_paginate', '~> 4.0'
gem 'trestle'
gem 'pg_search'

group :development do
  gem "web-console"
  gem "letter_opener"

  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'json'

  gem 'capistrano', '~> 3.17.1', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-nvm', require: false
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
end
gem 'capistrano-rails-collection'
