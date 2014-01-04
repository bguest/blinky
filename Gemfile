source 'https://rubygems.org'

# You know like gems and stuff
gem 'rails', '4.0.0'              # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sqlite3'                     # Use sqlite3 as the database for Active Record
gem 'sass-rails', '~> 4.0.0'      # Use SCSS for stylesheets
gem 'slim'                        # Slim Templates
gem 'uglifier', '>= 1.3.0'        # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0'    # Use CoffeeScript for .js.coffee assets and views
gem 'jquery-rails'                # Use jquery as the JavaScript library
gem 'jbuilder', '~> 1.2'          # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'anjlab-bootstrap-rails', '~> 3.0.2.0', :require => 'bootstrap-rails' # Bootstrap
gem 'pi_piper', :git => 'https://github.com/bguest/blinky.git', :branch => 'stub-driver'
gem 'color'               # Color
gem 'bitmask_attributes'  # Bitmask

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'turbolinks'  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec-rails', '~> 2.4'
  gem "mocha", :require => false
  gem 'simplecov'
end

group :test do
  gem 'mocha', :require => false
  gem 'zeus', '0.13.4.pre2'
  gem 'simplecov'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use thin as the app server
gem 'thin'

group :development do
  gem 'capistrano', '~> 3.0.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'annotate', "~>2.6.0"
end

