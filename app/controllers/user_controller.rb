# frozen_string_literal: true

require_relative 'application_controller'

class UserController < ApplicationController
  get '/auth/?' do
    'Create user'
  end

  get '/logout/?' do
    session.clear
    redirect '/about/?'
  end
end
