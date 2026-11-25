class User < ApplicationRecord
  has_many :twitter_accounts

  has_secure_password

  validates :password, presence: true, on: :password_change

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
end
