class Article < ApplicationRecord
  default_scope -> { order(date: :desc) }
  has_many :user_art_connect
  has_many :user, through: :user_art_connect
  has_many :memos
  has_many :memo_users, through: :users, class_name: 'User', source: :user
end
