require './main'
require 'test/unit'
require 'rack/test'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_helloreturns_hello_world
    get '/hello'
    assert last_response.ok?
    assert_equal "{\"hello_message\":\"Hello World!\"}", last_response.body
  end
end
