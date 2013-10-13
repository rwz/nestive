require 'bundler'

Bundler.setup

require 'rails'
require 'combustion'
require 'nestive'

Combustion.initialize! :action_controller

require 'rspec/rails'
