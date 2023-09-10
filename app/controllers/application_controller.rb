# frozen_string_literal: true

require_relative '../helpers/application_helper'

class ApplicationController < Sinatra::Base
  configure do
    helpers ApplicationHelper

    set :views, './app/views'
    set :public_folder, './app/assets'

    # __FILE__ is the current file
    set :root, File.dirname(__FILE__)

    register Sinatra::ActiveRecordExtension
    set :database_file, '../../config/database.yml'

    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    enable :sessions

    set :session_store, Rack::Session::Pool

    use Rack::Protection

    register Sinatra::Flash
  end

  configure :development do
    register Sinatra::Reloader
  end

  # @view format the erb response
  def erb_response(file)
    headers['Content-Type'] = 'text/html'
    erb file
  end

  # @view page not_found
  not_found do
    erb_response :not_found
  end
end
