require "sinatra/activerecord"

class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  # validates :autor, presence: true
end
