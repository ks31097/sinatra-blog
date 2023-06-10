ENV['APP_ENV'] = 'test'

require '../main'
require 'rack/test'

# set :environment, :test

def app
  Sinatra::Application
end

describe 'The MyBlog App' do
  include Rack::Test::Methods

  it "should load response with 200 for home page ('/')" do
    get '/'
    expect(last_response.status).to eq(200)
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

  it "should load response with 200 for about page ('/about')" do
    get '/about'
    expect(last_response.status).to eq(200)
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

  it "should load the response with 404 if page not_found" do
    get "not_found"
    expect(last_response.status).to eq(404)
  end

  it "should show information on the page not_found" do
    get "not_found"
    expect(last_response.body).to include("<h2>4 Oh 4!</h2>")
    expect(last_response.body).to include("<p>The page you are looking for is missing. Why not go back to the <a href='/' title='Home page'>home page</a> and start over?</p> ")
  end

  it "should redirect from the not_found page to the main page ('/')" do
    get "not_found"
    expect(last_response.redirect('/'))
    follow_redirect!
    expect(last_response.body).to include("<title>Blog</title>")
    expect(last_response.body).to include("<h1>Hello, world!</h1>")
    expect(last_response.body).to include("<p>Main page!</p>")
    expect(last_response.body).to include("<a href=\"/about\" title=\"About\">About</a>")
  end
end
