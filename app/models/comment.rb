class Comment < ApplicationRecord
  has_one :users_comment
  belongs_to :user, through: :users_comment

  has_one :articles_comment
  belongs_to :article, through: :articles_comment
end
