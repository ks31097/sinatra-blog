# Include all the gem listed in Gemfile

require 'bundler'
Bundler.require

# __FILE__ is the current file

require './app/controllers/user_controller'
require File.join(File.dirname(__FILE__), '../app/controllers/app_controller.rb')
