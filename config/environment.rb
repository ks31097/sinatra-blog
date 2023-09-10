# frozen_string_literal: true

require 'bundler' # Include all the gem listed in Gemfile
Bundler.require

require_relative '../app/controllers/about_controller'
require_relative '../app/controllers/user_controller'
require_relative '../app/controllers/article_controller'
# __FILE__ is the current file
require_relative File.join(File.dirname(__FILE__), '../app/controllers/application_controller.rb')
