source 'https://rubygems.org'

# You know like gems and stuff
gem 'rails',        '~>4.0'       # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'sqlite3',      '~>1.3'       # Use sqlite3 as the database for Active Record
gem 'pg',           '~>0.17.1'    # Use postgres
gem 'sass-rails',   '~>4.0'       # Use SCSS for stylesheets
gem 'slim',         '~>2.0'       # Slim Templates
gem 'uglifier',     '~>2.4'       # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~>4.0'       # Use CoffeeScript for .js.coffee assets and views
gem 'jquery-rails', '~>3.1'       # Use jquery as the JavaScript library
gem 'jbuilder',     '~>2.0'       # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'anjlab-bootstrap-rails', '~> 3.0', :require => 'bootstrap-rails' # Bootstrap
gem 'pi_piper', :git => 'https://github.com/bguest/pi_piper.git', :branch => 'develop'
#gem 'color',              '~>1.4' # Color
gem 'color', :github => 'bguest/color', :branch => 'bug-nil-equivalent'
gem 'bitmask_attributes', '~>1.0' # Bitmask
gem 'annotate', "~>2.6"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
 
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'pry-byebug', '~>3.0'
  gem 'rspec-rails', '~> 3.1'
  gem "mocha", :require => false
  gem 'simplecov'
end

group :test do
  gem 'minitest', '~>5.5'
  gem 'shoulda-matchers', '~>2.5'
  gem 'zeus', '0.13.4.pre2'
  gem 'coveralls', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use thin as the app server
gem 'thin', '~>1.6'

group :development do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-scm-copy', '~>0.5.0'
  gem 'capistrano-scm-gitcopy', '~>0.0.8'
end

