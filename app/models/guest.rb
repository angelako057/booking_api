class Guest < ApplicationRecord
  has_many :reservations

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :first_name, :last_name, presence: true
end
