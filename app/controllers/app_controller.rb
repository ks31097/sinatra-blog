require 'sinatra/base'
require 'securerandom'
require 'sinatra/json'
require 'sinatra/reloader'

class AppController < Sinatra::Base
 configure do
   set :views, './app/views'

   set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

   enable :sessions
 end

 configure :development do
   register Sinatra::Reloader
 end

  not_found do
    erb 'error/not_found'.to_sym
  end
end
