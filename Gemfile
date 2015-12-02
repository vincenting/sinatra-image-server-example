source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib', require: 'sinatra/json'
gem 'rack-protection', require: 'rack/protection'

gem 'redis', require: 'redis'
gem 'hiredis', '~> 0.4.5'
# others
gem 'dotenv', require: 'dotenv'
gem 'sidekiq', require: 'sidekiq'
gem 'rake'
gem 'secure_headers', require: 'secure_headers'
gem 'addressable', require: 'addressable/uri'
gem 'mini_magick', require: 'mini_magick'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rerun', require: false
  gem 'cane', require: false
end

group :production do
  gem 'puma'
end

group :test do
  gem 'minitest', require: false
  gem 'simplecov', require: false
  gem 'mocha', require: false
end
