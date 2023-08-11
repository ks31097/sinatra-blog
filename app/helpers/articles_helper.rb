module ArticlesHelper
  def title(title='Blog')
    @title = title
  end

  def time_now
    Time.now
  end

  def find_articles
    @articles = Article.all
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def article_error(article)
    article.errors.full_messages
  end

  private

  def create_article
    @article = Article.new params[:article]
  end

  def data_json(created: false)
    payload = JSON.parse request.body.read
      if created
        payload['created_at'] = time_now
        payload['updated_at'] = time_now
      end

    payload
  end
end
