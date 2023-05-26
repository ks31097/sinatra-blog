require 'sinatra'
require 'sinatra/json'

get '/hello' do
  message = { hello_message: 'Hello World!' }
  json message
end
