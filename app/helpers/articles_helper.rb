module ArticlesHelper

  # @title for the views
  def title(title='Blog')
    @title = title
  end

  # @show the current time
  def time_now
    Time.now
  end

  # @find all articles
  def find_articles
    Article.all
  end

  # @find the article
  def find_article
    Article.find(article_id)
  end

  # @format the article sinatra-flash errors
  def article_error(article)
    article.errors.full_messages
  end

  private

  # @create the article
  def create_article
    Article.new(article_params)
  end

  # @format body data_json
  def data_json(created: false)
    payload = JSON.parse request.body.read
      if created
        payload['created_at'] = time_now
        payload['updated_at'] = time_now
      end

    payload
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

end
