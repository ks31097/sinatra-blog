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

  # @method: Display all articles in json
  # $curl 127.0.0.1:9292/articles_json
  get '/articles_json/?' do
    json_response(data: find_articles)
  end

  # @views/index: Render an erb file which shows all atricles
  get '/?' do
    begin
      title 'Articles:'
      find_articles

      erb_response 'index'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

  # @method: Add a new article to the DB
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{}'
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{"id":8,"title":"Article","content":"This is new article","autor":"Autor"}'
  post '/articles_json/create' do
    begin
      article = Article.create( self.data_json(created: true) )

      if article_error(article).length > 0 then
        json_response_db(data: article, message: article_error(article))
      else
        json_response_db(data: article, message: 'Article add to the DB')
      end
    rescue => e
      json_response(code: 422, data: { error: e.message })
    end
  end

  # @views/index: Render an erb file for add new article
  get '/articles/new/?' do
    create_article

    erb_response 'new_article'.to_sym
  end

  # @method: Add a new article to the DB
  post '/articles/new/?' do
    begin
      create_article

      if @article.save
        redirect to("/articles/#{@article.id}")
      else
        @article_error = article_error(@article)

        flash.now[:article_error] = article_error(@article)
        erb_response 'new_article'.to_sym
      end

    rescue => e
      error_response(404, e)
    end
  end

  # @method: Display the article in json
  get '/articles_json/:id/?' do
    json_response(data: find_article)
  end

  # @views/show: Render an erb file which show the article
  get '/articles/:id/?' do
    begin
      find_article

      erb_response 'show'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

end
