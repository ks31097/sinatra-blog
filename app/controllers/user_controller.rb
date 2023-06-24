require './app/controllers/app_controller'

class UserController < AppController
  get '/?' do
    session[:info] = 'turn on'
    title 'Hello, world!'
    @message = 'Main page!'
    @home_info = session[:info]
    erb 'home'.to_sym
  end

  get '/about/?' do
    title "About"
    @about_info = session[:info]
    erb 'about'.to_sym
  end

  get '/logout/?' do
    session.clear
    redirect '/about/?'
  end
end
