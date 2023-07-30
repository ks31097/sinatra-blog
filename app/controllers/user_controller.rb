require './app/controllers/app_controller'
require './app/models/article'

class UserController < AppController
  get '/?' do
    session[:info] = 'turn on'
    title 'Hello, world!'
    @message = 'Main page!'
    @home_info = session[:info]
    @articles = Article.all
    erb 'index'.to_sym
    # Article.find_or_create_by(title: 'First article').to_json
  end

  get '/about/?' do
    title 'About'
    @about_info = session[:info]
    erb 'about'.to_sym
  end

  get '/logout/?' do
    session.clear
    redirect '/about/?'
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb 'show'.to_sym
  end
end
