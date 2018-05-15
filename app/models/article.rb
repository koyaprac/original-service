class Article < ApplicationRecord
  default_scope -> { order(date: :desc) }
  has_many :user_art_connect
  has_many :user, through: :user_art_connect
end
