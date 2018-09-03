class User < ApplicationRecord
  acts_as_voter
  has_many :posts
  has_many :comments
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :username, presence: true, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 5 }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end
