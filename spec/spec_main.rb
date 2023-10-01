ENV['APP_ENV'] = 'test'
require './spec/spec_helper'

APP = Rack::Builder.parse_file("config.ru").first

RSpec.describe 'My Blog' do
  include Rack::Test::Methods

  def app
    APP
  end

  it "load home page ('/?')" do
    get '/?'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Articles')
  end

  it "load about page ('/about')" do
    get '/about'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('about.erb')
  end

  it "load not_found" do
    get "not_found"
    expect(last_response.status).to equal(404)
    expect(last_response.body).to include("4 Oh 4!")
    expect(last_response.body).to include("The page you are looking for is missing.")
  end
end
