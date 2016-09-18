class Article < ApplicationRecord
  include Authority::Abilities

  acts_as_taggable_on :categories

  belongs_to :user
  has_many :comments

  validates_presence_of :title, :content

  scope :with_category, lambda { |category|
    tagged_with(category, on: :categories) if category.present?
  }
end
