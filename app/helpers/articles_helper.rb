# frozen_string_literal: true

module ArticlesHelper
  # @title for the views
  def title(title = 'Blog')
    @title = title
  end

  # @find all articles
  def find_articles
    Article.all
  end

  private

  # @find the article
  def find_article
    Article.find(article_id)
  end

  # @create the article
  def create_article
    Article.new(article_params)
  end

  # @update_article
  def update_article(article)
    article.update(article_params)
  end

  # @retrieve :id
  def article_id
    params[:id].to_i
  end

  # @get article params
  def article_params
    params[:article]
  end

  def logged_in?
    session[:user_id]
  end

  # @error: user not logged in
  def redirect_if_not_logged_in
    flash.next[:warning] = 'You are not log in!'
    redirect '/log_in'
  end

  def article_author(user_id)
    User.find(user_id).full_name
  end
end
