# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/user_helper'
require_relative '../models/user'

class UserController < ApplicationController
  configure do
    helpers UserHelper
  end

  get '/sign_up/?' do
    @user = create_user

    erb_response :sign_up
  end

  post '/sign_up/?' do
    @user = create_user

    if @user.save
      session[:user_id] = @user.id
      session[:full_name] = @user.full_name
      flash.next[:success] = "Welcome #{session[:full_name]}"
      redirect to '/?'
    else
      flash.now[:warning] = error_message(@user)
      erb_response :sign_up
    end
  rescue StandardError
    erb_response :not_found
  end

  get '/log_in/?' do
    erb_response :log_in
  end

  post '/log_in/?' do
    user = find_user

    if user && user_password(user)
      session[:user_id] = user.id
      session[:full_name] = user.full_name
      flash.next[:success] = "Welcome #{session[:full_name]}"
      redirect to '/?'
    else
      flash.next[:warning] = 'Something wrong, try again!'
      redirect to '/log_in'
    end
  rescue StandardError
    erb_response :not_found
  end

  get '/log_out/?' do
    session.clear
    redirect to '/?'
  end
end
