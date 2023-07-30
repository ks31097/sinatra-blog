# frozen_string_literal: true

require './config/environment'
require './app/helpers/app_helper'

class AppController < Sinatra::Base
  configure do # Global settings
    helpers AppHelper

    set :views, './app/views'

    set :root, File.dirname(__FILE__) # __FILE__ is the current file

    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    enable :sessions

    register Sinatra::ActiveRecordExtension
    set :database_file, '../../config/database.yml'
  end

  configure :development do # Development settings
    register Sinatra::Reloader # Refresh the app without restarting the web server
  end

  # @api: Format the json response
  def json_response(code: 200, data: nil)
    status = [200, 201].include?(code) ? 'SUCCESS' : 'FAILED'
    headers['Content-Type'] = 'application/json' # content_type :json

    if data
      { code: code, data: data, message: status }.to_json
    end
  end

  # api: Format JSON error responses
  def error_response(code, e)
    json_response(code: code, data: { error: e.message })
  end

  # @api: 404
  not_found do
    json_response(code: 404, data: { error: 'The page you are looking for is missing' })
  end
end
