# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/user_helper'
require_relative '../models/user'

class UserController < ApplicationController

  configure do
    helpers UserHelper
  end

  get '/sign_in/?' do
    @user = create_user

    erb_response 'sign_in'.to_sym
  end

  post '/sign_in/?' do
    begin
      @user = create_user

      if @user.save
        session[:user_id] = @user.id
        redirect to '/?'
      else
        flash.now[:sign_in_error] = user_error(@user)
        erb_response 'sign_in'.to_sym
      end
    rescue => e
      error_response(422, e)
    end
  end

  get '/log_in/?' do
    erb_response 'log_in'.to_sym
  end

  post '/log_in/?' do
    begin
      user = find_user

      if user && user_password(user)
        # user_password = user.authenticate(params[:user][:password])
        # user_password = BCrypt::Password.new(user.password_digest) == params[:user][:password]
        session[:user_id] = user.id
        redirect to '/?'
      elsif user && !user_password(user)
        flash.next[:log_in_error] = 'Something wrong, try again!'
        redirect to '/log_in'
      else !user
        flash.next[:log_in_error] = 'Sign in!'
        redirect to '/sign_in'
      end
    rescue => e
      error_response(422, e)
    end
  end

  # $curl -X POST 127.0.0.1:9292/auth/register -d '{}'
  #@method: json create a new user
  post '/auth/register/?' do
    begin
      user = User.create(self.json_user_data(created: true))

      session[:json_user_id] = user.id

      if json_user_error(user).length > 0 then
        json_response_db(data: user, message: json_user_error(user))
      else
        json_response(code: 201, data: {
          session: session[:json_user_id],
          user: user
        })
      end
    rescue => e
      error_response(422, e)
    end
  end

  # $curl -X POST 127.0.0.1:9292/auth/register -d '{}'
  #@method: log in user using email and password
  post '/auth/login' do
    begin
      payload = json_user_data # payload['email'], payload['password']

      user = User.find_by(email: payload['email'])

    if user && user.authenticate(payload['password'])
      session[:json_user_id] = user.id
      json_response(code: 200, data: {
        id: user.id,
        email: user.email,
        session: session[:json_user_id]
       })
     else
      json_response(code: 422, data: { message: 'Your email/password combination is not correct!' })
    end
   rescue => e
      error_response(422, e)
    end
  end

  get '/log_out/?' do
    session.clear
    redirect to '/?'
  end
end
