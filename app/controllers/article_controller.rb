# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/articles_helper'
require_relative '../models/article'

class ArticleController < ApplicationController
  configure do
    helpers ArticlesHelper

    register Sinatra::ActiveRecordExtension
    set :database_file, '../../config/database.yml'
  end

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
end
