class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :expiration_deadline, presence: true
end
