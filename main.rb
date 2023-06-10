require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?

get '/?' do
  @title = 'Hello, world!'
  @message = 'Main page!'
  erb 'home'.to_sym
end

get '/about/?' do
  @title = "About"
  erb 'about'.to_sym
end

not_found do
  erb 'errors/not_found'.to_sym
end

error do
  erb 'errors/internal_server_error'.to_sym
end
