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

  not_found do
    erb 'error/not_found'.to_sym
  end
end
