class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :tasks, dependent: :destroy

  has_secure_password
end
