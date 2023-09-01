# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/articles_helper'
require_relative '../models/article'

class ArticleController < ApplicationController
  configure do
    helpers ArticlesHelper
  end

  # @method: Display a small welcome message
  get '/hello' do
    'The server is up and running!'
  end

  # @method: Display all articles in json
  # $curl 127.0.0.1:9292/articles_json
  get '/articles_json/?' do

      puts session: session[:json_user_id]
    puts session: session[:user_id]
    articles = find_articles
    if articles.to_s.length > 0 then
      json_response(data: articles)
    else
      json_response(data: 'No articles have been created yet!')
    end
  end

  # @views/index: Render an erb file which shows all atricles
  get '/?' do
    begin
      title 'Articles:'
      @articles = find_articles

      erb_response 'index'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

  # @method: Add a new article to the DB
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{}'
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{"id":8,"title":"Article","content":"This is new article","autor":"Autor"}'
  post '/articles_json/create/?' do
    # puts session: session[:json_user_id]
    # puts session: session[:user_id]
    # if session[:user_id]
    if json_user_loggedin?
      begin
        article = Article.create( self.data_json(created: true) )

        if article_error(article).length > 0 then
          json_response_db(data: article, message: article_error(article))
        else
          json_response_db(data: article, message: 'Current article')
       end
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    else
      json_response(code: 422, data: { error: json_not_logged_message })
    end
  end

  # @views/new_article: Render an erb file for add new article
  get '/articles/new/?' do
    # puts session[:user_id]
    unless !logged_in?
      @article = create_article
      erb_response 'new_article'.to_sym
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Add a new article to the DB
  post '/articles/new/?' do
    unless !logged_in?
      begin
        @article = create_article

        if @article.save
          flash.next[:article_added] = "Article successfully added!"
          redirect to "/articles/#{@article.id}"
        else
          # @article_error = article_error(@article)
          flash.now[:article_error] = article_error(@article)
          erb_response 'new_article'.to_sym
        end
      rescue => e
        error_response(404, e)
      end
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Display the article in json
  get '/articles_json/:id/?' do
    json_response(data: find_article)
  end

  # @views/show_article: Render an erb file which show the article
  get '/articles/:id/?' do
    begin
      @article = find_article

      erb_response 'show_article'.to_sym
    rescue => e
      error_response(404, e)
    end
  end

  # @method: Update existing article in the DB according to :id
  # curl -X PUT 127.0.0.1:9292/articles_json/1/edit -d '{}'
  put '/articles_json/:id/edit/?' do
    if json_user_logged_in?
      begin
        article = Article.find(self.article_id)
        article.update(self.data_json)

        if article_error(article).length > 0 then
          json_response_db(data: article, message: article_error(article))
        else
          json_response_db(data: article, message: 'Current article')
        end
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    else
      json_response(code: 422, data: { error: json_not_logged_message })
    end
  end

  # @views/edit_article: Render an edit erb file for edit the article
  get '/articles/:id/edit/?' do
    unless !logged_in?
      begin
        @article = find_article

        erb_response 'edit_article'.to_sym
      rescue => e
        error_response(404, e)
      end
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Updating the article in the DB
  put '/articles/:id/?' do
    unless !logged_in?
      begin
        @article = find_article
        @article.update(article_params)

        flash.next[:article_updated] = "Article successfully updated"
        redirect to "/articles/#{@article.id}"
      rescue => e
        error_response(404, e)
      end
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Delete the article in the DB according to :id
  # curl -X DELETE 127.0.0.1:9292/articles_json/15/destroy
  delete '/articles_json/:id/destroy/?' do
    if json_user_logged_in?
      begin
        article = Article.find(self.article_id)
        article.destroy
        json_response(data: { message: "Article deleted successfully!" })
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    else
      json_response(code: 422, data: { error: json_not_logged_message })
    end
  end

  delete '/articles/:id' do
      unless !logged_in?
        begin
          @article = find_article
          @article.destroy

          flash.next[:article_del] = "Article deleted successfully!"
          redirect to '/'
        rescue => e
          error_response(404, e)
        end
      else
        redirect_if_not_logged_in
      end
    end
end
