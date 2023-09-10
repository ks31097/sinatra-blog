# frozen_string_literal: true

module UserHelper
  private

  def create_user
    User.new(user_params)
  end

  def user_params
    params[:user]
  end

  def user_params_email
    params[:user][:email]
  end

  def find_user
    User.find_by_email(user_params_email)
  end

  def user_params_password
    params[:user][:password]
  end

  def user_password(user)
    user.authenticate(user_params_password)
  end
end
