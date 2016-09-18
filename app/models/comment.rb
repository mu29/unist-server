class Comment < ApplicationRecord
  include Authority::Abilities

  paginates_per 50

  belongs_to :user
  belongs_to :article

  validates_presence_of :content
end
