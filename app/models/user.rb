class User < ApplicationRecord
  has_secure_password

  has_many :articles
  has_many :comments

  validates :email, :name, uniqueness: true
  validates_presence_of :email, :password_digest, :name

  before_create :generate_confirm_token

  private

  def generate_confirm_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
