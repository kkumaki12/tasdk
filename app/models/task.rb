class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :expiration_deadline, presence: true

  scope :recent, -> { order(created_at: 'DESC') }
  scope :near_deadline, -> { order(expiration_deadline: 'ASC') }
end
