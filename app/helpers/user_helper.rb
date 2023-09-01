module UserHelper

  private

  def time_now
    Time.now
  end

  # @format the user sinatra-flash errors
  def user_error(user)
    user.errors.full_messages
  end

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

  # @helper: parse user JSON data
  def json_user_data(created: false)
     payload = JSON.parse request.body.read
      if created
        payload['password_digest'] = BCrypt::Password.create(payload['password_digest'])
        payload['created_at'] = time_now
        payload['updated_at'] = time_now
      end

    payload
  end

  def json_user_error(user)
    user.errors.full_messages
  end
end
