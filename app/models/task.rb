class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :expiration_deadline, presence: true

  enum status: {
    not_started_yet: 0,
    under_start: 1,
    completion: 2
  }

  scope :recent, -> { order(created_at: 'DESC') }
  scope :near_deadline, -> { order(expiration_deadline: 'ASC') }
end
