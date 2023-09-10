# frozen_string_literal: true

require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_secure_password

  has_many :articles

  validates :full_name, presence: true, length: { minimum: 4 }
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 5 }
end
