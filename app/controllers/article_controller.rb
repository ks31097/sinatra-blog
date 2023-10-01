# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/articles_helper'
require_relative '../models/article'

class ArticleController < ApplicationController
  configure do
    helpers ArticlesHelper
  end

  # @method: Display the small welcome message
  get '/hello' do
    'The server is up and running!'
  end

  # @views/index: Display all atricles
  get '/?' do
    title 'Articles:'
    @articles = find_articles

    erb_response :index
    rescue StandardError
      erb_response :not_found
  end

  # @views/new_article: Add new article
  get '/articles/new/?' do
    if logged_in?
      @article = create_article

      erb_response :new_article
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Save the new article in the DB
  post '/articles/new/?' do
    if logged_in?
      begin
        @article = create_article
        @article.user_id = session[:user_id]

        if @article.save
          flash.next[:success] = 'Article successfully added!'
          redirect to "/articles/#{@article.id}"
        else
          flash.now[:warning] = error_message(@article)
          erb_response :new_article
        end
      rescue StandardError
        erb_response :not_found
      end
    else
      redirect_if_not_logged_in
    end
  end

  # @views/show_article: Show the article
  get '/articles/:id/?' do
    @article = find_article

    erb_response :show_article
  rescue StandardError
    erb_response :not_found
  end

  # @views/edit_article: Edit the article
  get '/articles/:id/edit/?' do
    if logged_in?
      begin
        @article = find_article

        erb_response :edit_article
      rescue StandardError
        erb_response :not_found
      end
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Updating the article in the DB
  put '/articles/:id/?' do
    if logged_in?
      begin
        @article = find_article
        @article.update(article_params)

        flash.next[:success] = 'Article successfully updated'
        redirect to "/articles/#{@article.id}"
      rescue StandardError
        erb_response :not_found
      end
    else
      redirect_if_not_logged_in
    end
  end

  # @method: Delete the article from the DB
  delete '/articles/:id' do
    if logged_in?
      begin
        @article = find_article
        @article.destroy

        flash.next[:success] = 'Article deleted successfully!'
        redirect to '/'
      rescue StandardError
        erb_response :not_found
      end
    else
      redirect_if_not_logged_in
    end
  end
end
