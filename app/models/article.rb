class Article < ApplicationRecord
  has_one :users_article
  belongs_to :user, through: :users_article

  has_many :articles_comments
  has_many :comments, through: :articles_comments
end
