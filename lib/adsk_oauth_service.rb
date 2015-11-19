require 'yaml'
require 'configger_service'

Dir["#{File.dirname(__FILE__)}/services/**/*.rb"].each { |f| require f }

