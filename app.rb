require 'rubygems'
require 'multi_json'
require 'bundler/setup'

Bundler.require :default
Dotenv.load '.env'

set :root, File.dirname(__FILE__)

require 'sinatra/base'
require 'fileutils'
%w(config extensions workers controllers).each do |p|
  Dir[File.join(File.dirname(__FILE__), p, '**', '*.rb')].each { |f| require f }
end
