class User < ApplicationRecord
  has_secure_password

  has_many :articles
  has_many :comments

  validates :email, :name, uniqueness: true
  validates_presence_of :email, :password_digest, :name
end
