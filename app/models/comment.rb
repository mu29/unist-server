class Comment < ApplicationRecord
  include Authority::Abilities

  belongs_to :user
  belongs_to :article

  validates_presence_of :content
end
