class User < ApplicationRecord
  has_secure_password

  has_many :articles
  has_many :comments

  validates_presence_of :email, :password_digest, :name
end
