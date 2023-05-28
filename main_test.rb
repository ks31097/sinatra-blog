require './main'
require 'rack/test'
require 'test/unit'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_returns_main_page_info
    get '/'
    assert last_response.ok?
    assert last_response.body.include?("<h1>Hello, world!</h1>\n")
    assert last_response.body.include?("<p>Main page!</p>\n")
    assert last_response.body.include?("<a href=\"/about\" title=\"About\">About</a>\n")
  end

  def test_it_returns_about_page_info
    get '/about'
    assert last_response.ok?
    assert last_response.body.include?("<h1>About</h1>\n")
    assert last_response.body.include?("<p>This message is from about.erb</p>\n")
    assert last_response.body.include?("<a href=\"/\" title=\"Main page\">Main page</a>\n")
  end
end
