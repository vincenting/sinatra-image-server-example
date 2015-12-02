configure :development do
  Bundler.require :development
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

configure do
  require 'logger'
  set :logger,  Logger.new("#{settings.root}/logs/#{settings.environment}.log", 'daily')
end
