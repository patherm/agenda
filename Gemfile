source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

#gem 'pg'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'devise'
gem 'net-ldap', '~> 0.16.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'sprockets-rails', '~> 3.2', '>= 3.2.1'
gem 'simple_form', '~> 3.5'
gem 'compass-rails','~> 3.0.2'
gem 'searchkick', '~> 3.1'
gem 'elasticsearch', '~> 6.1'
gem 'rails-jquery-autocomplete'
#gem 'autocomplete', '~> 1.0', '>= 1.0.2'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'
#gem 'net-ldap', '~> 0.16.1'
gem 'devise_ldap_authenticatable', '~> 0.8.6'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

platforms :ruby do # linux

gem 'kgio'
gem 'unicorn'

end
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.3', '>= 1.3.1', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3'
end

group :production do
	gem 'pg'
  	gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
