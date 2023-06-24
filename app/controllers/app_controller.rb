# Include all the gem listed in Gemfile

require 'bundler'
Bundler.require

class AppController < Sinatra::Base

  # Global settings
  configure do
    set :views, './app/views'

    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

    enable :sessions
  end

 # development settings
  configure :development do
    # this allows us to refresh the app on the browser without needing to restart the web server
    register Sinatra::Reloader
  end

  def not_found_response
    json(code: 404, data: { error: "You seem lost. That route does not exist." })
  end

  not_found do
    # not_found_response
    # erb 'error/not_found'.to_sym
    content_type :json

    { status: 404, message: 'Nothing found!' }.to_json
  end
end
