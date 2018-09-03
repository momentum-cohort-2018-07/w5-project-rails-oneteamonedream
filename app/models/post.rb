class Post < ApplicationRecord
  acts_as_votable
  has_many :comments
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }
end
