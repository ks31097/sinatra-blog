# frozen_string_literal: true

require_relative 'application_controller'

class AboutController < ApplicationController
  get '/about/?' do
    erb_response :about
  rescue StandardError
    erb_response :not_found
  end
end
