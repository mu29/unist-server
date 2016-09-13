class User < ApplicationRecord
  has_secure_password

  has_many :users_articles
  has_many :articles, through: :users_articles

  has_many :users_comments
  has_many :comments, through: :users_comments
end
