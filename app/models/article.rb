class Article < ApplicationRecord
  include Authority::Abilities

  belongs_to :user
  has_many :comments

  validates_presence_of :title, :content
end
