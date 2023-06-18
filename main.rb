require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require 'securerandom'

# set :views, './app/views'

set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

configure do
  enable :sessions
end

get '/?' do
  session[:info] = 'turn on'
  @title = 'Hello, world!'
  @message = 'Main page!'
  @home_info = session[:info]
  erb 'home'.to_sym
end

get '/about/?' do
  @title = "About"
  @about_info = session[:info]
  erb 'about'.to_sym
end

get '/logout/?' do
  session.clear
  redirect '/about/?'
end

not_found do
  erb 'errors/not_found'.to_sym
end

error do
  erb 'errors/internal_server_error'.to_sym
end
