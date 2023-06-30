ENV['APP_ENV'] = 'test'

require './app/controllers/user_controller'
require 'rack/test'
 
def app
  UserController
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
  end

  it "should load the response with 404 if page not_found" do
    get "not_found"
    expect(last_response.status).to eq(404)
  end

  it "should show information on the page not_found" do
    get "not_found"

    expect(last_response.body).to include("404")
    expect(last_response.body).to include("Nothing found!")

    # expect(last_response.body).to include("<h2>4 Oh 4!</h2>")
    # expect(last_response.body).to include("<p>The page you are looking for is missing. Why not go back to the <a href='/' title='Home page'>home page</a> and start over?</p> ")
  end

  it "should redirect from the not_found page to the main page ('/')" do
    get "not_found"
    expect(last_response.redirect('/'))
    follow_redirect!
    expect(last_response.body).to include("<title>Blog</title>")
    expect(last_response.body).to include("<h1>Hello, world!</h1>")
    expect(last_response.body).to include("<p>Main page!</p>")
  end

  it "should test the session main page ('/')" do
    browser = Rack::Test::Session.new(Rack::MockSession.new(app))
    browser.get '/'
    expect(browser.last_response.body).to include('turn on')
  end

  it "should test the session about page ('/about')" do
    browser = Rack::Test::Session.new(Rack::MockSession.new(app))
    browser.get '/about'
    expect(browser.last_response.body).to include('turn off')
  end
end
