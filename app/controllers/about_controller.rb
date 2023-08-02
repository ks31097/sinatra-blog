# frozen_string_literal: true

require_relative 'application_controller'

class AboutController < ApplicationController
  get '/about/?' do
    begin
      @about_info = session[:info]

      erb 'about'.to_sym
    rescue => e
      error_response(404, e)
    end
  end
end
