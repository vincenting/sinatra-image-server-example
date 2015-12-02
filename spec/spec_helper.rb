ENV['RACK_ENV'] = 'test'

require 'simplecov'
require 'minitest/autorun'
require 'rack/test'
require 'multi_json'

include Rack::Test::Methods

SimpleCov.start do
  add_group 'Controllers', 'controllers'
  add_group 'Extensions', 'extensions'
  add_group 'Workers', 'workers'

  add_filter '/spec/'
  add_filter '/config/'
  add_filter 'app.rb'
end

require_relative '../app'

def app
  Sinatra::Application
end
