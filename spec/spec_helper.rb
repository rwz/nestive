require 'bundler/setup'
require 'rails'
require 'combustion'

require File.expand_path('../../lib/nestive', __FILE__)

Combustion.initialize! :action_controller

require 'rspec/rails'