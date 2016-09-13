class Article < ApplicationRecord
  has_one :users_article
  belongs_to :user, through: :users_article
end
