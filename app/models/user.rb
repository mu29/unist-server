class User < ApplicationRecord
  has_secure_password

  has_many :users_articles
  has_many :articles, through: :users_articles
end
