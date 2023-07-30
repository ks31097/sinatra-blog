# frozen_string_literal: true

require './app/controllers/app_controller'
require './app/models/article'

class UserController < AppController
  get '/?' do
    begin
      session[:info] = 'turn on'
      title 'Hello, world!'
      @message = 'Main page!'
      @home_info = session[:info]
      @articles = Article.all

      erb 'index'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

  get '/about/?' do
    begin
      title 'About'
      @about_info = session[:info]

      erb 'about'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

  get '/articles/:id/?' do
    begin
      @article = Article.find(params[:id])

      erb 'show'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

  get '/logout/?' do
    session.clear
    redirect '/about/?'
  end
end
