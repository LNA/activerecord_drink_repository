$: << File.expand_path(File.dirname(__FILE__)) + '/../'
$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/'
ENV["RACK_ENV"] = "test"

require 'rack/test'
require 'drink_app'

def app
  Sinatra::Application
end

#makes Rake::Test available to all contexts
RSpec.configure do |config|
  config.include Rack::Test::Methods
end

