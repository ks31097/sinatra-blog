# __FILE__ is the current file

# require './app/controllers/user_controller'
# require File.join(File.dirname(__FILE__), './app/controllers/app_controller.rb')

require_relative './config/environment'

use UserController
run AppController
