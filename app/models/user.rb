class User < ApplicationRecord
  has_many :stores
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
