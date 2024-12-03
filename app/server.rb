# Include all the gems listed in Gemfile
require 'bundler'
Bundler.require

module GroceryList
  class Server < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__)
      set :bind, '0.0.0.0'
    end
  end
end

# Load all route files
Dir[File.dirname(__FILE__) + "/routes/**"].each do |route|
  require route
end