require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?

get '/?' do
  @message = 'Main page!'
  erb :home
end

get '/about/?' do
  @title = "About"
  erb :about
end
