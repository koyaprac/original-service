class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :user_art_connect
  has_many :article, through: :user_art_connect
  has_many :favorites
  has_many :favorite_items, through: :favorites, class_name: 'Article', source: :article
  has_many :readlaters
  has_many :readlater_items, through: :readlaters, class_name: 'Article', source: :article
  
  def favorite(article)
    self.favorites.find_or_create_by(article_id: article.id)
  end
  
  def unfavorite(article)
    fav = self.favorites.find_by(article_id: article.id)
    fav.destroy if fav
  end
  
  def favorite?(article)
    self.favorite_items.include?(article)
  end
  
  def readlater(article)
    self.readlaters.find_or_create_by(article_id: article.id)
  end
  
  def unreadlater(article)
    lat = self.readlaters.find_by(article_id: article.id)
    lat.destroy if lat
  end
  
  def readlater?(article)
    self.readlater_items.include?(article)
  end
end