# frozen_string_literal: true

require 'sinatra/activerecord'
require 'uri'

class User < ActiveRecord::Base
  has_secure_password

  has_many :articles

  validates_presence_of :full_name, :email, :password
  validates_length_of :full_name, :password, minimum: 5
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
