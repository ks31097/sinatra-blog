ENV['APP_ENV'] = 'test'

require '../main'
require 'rack/test'

# set :environment, :test

def app
  Sinatra::Application
end

describe 'The MyBlog App' do
  include Rack::Test::Methods

  it "should load the home page ('/')" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should show information on the home page ('/')" do
    get '/'
    expect(last_response.body).to include("<title>Blog</title>")
    expect(last_response.body).to include("<h1>Hello, world!</h1>")
    expect(last_response.body).to include("<p>Main page!</p>")
    expect(last_response.body).to include("<a href=\"/about\" title=\"About\">About</a>")
  end

  it "should redirect from the home page ('/') to the about page ('/about')" do
    get "/"
    expect(last_response.redirect('/about'))
    follow_redirect!
    expect(last_response.body).to include("<title>Blog</title>")
    expect(last_response.body).to include("<h1>About</h1>")
    expect(last_response.body).to include("<p>This message is from about.erb</p>")
  end

  it "should load the about page ('/about')" do
    get '/about'
    expect(last_response).to be_ok
  end

  it "should show information on the about page ('/about')" do
    get '/about'
    expect(last_response.body).to include("<title>Blog</title>")
    expect(last_response.body).to include("<h1>About</h1>")
    expect(last_response.body).to include("<p>This message is from about.erb</p>")
  end

  it "should redirect from the about page ('/about') to the main page ('/')" do
    get "/about"
    expect(last_response.redirect('/'))
    follow_redirect!
    expect(last_response.body).to include("<title>Blog</title>")
    expect(last_response.body).to include("<h1>Hello, world!</h1>")
    expect(last_response.body).to include("<p>Main page!</p>")
    expect(last_response.body).to include("<a href=\"/about\" title=\"About\">About</a>")
  end
end
