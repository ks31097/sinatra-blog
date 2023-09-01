require "sinatra/activerecord"
require 'bcrypt'

class User < ActiveRecord::Base

  has_secure_password

  has_many :articles

  # users.password_hash in the database is a :string
  # # include BCrypt

  # def password
    # @password ||= Password.new(password_hash)
  # end

  # def password=(new_password)
    # @password = Password.create(new_password)
    # self.password_hash = @password
  # end

  validates :full_name, presence: true, length: { minimum: 4 }
  validates :email, presence: true
  validates :password_digest, presence: true, length: { minimum: 5 }
end
