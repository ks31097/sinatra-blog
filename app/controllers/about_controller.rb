# frozen_string_literal: true

require_relative 'application_controller'

class AboutController < ApplicationController
  get '/about/?' do
    begin
      erb_response :about
    rescue
      erb_response :not_found
    end
  end
end
