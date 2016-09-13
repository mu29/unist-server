class Comment < ApplicationRecord
  has_one :users_comment
  belongs_to :user, through: :users_comment
end
