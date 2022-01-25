class Task < ApplicationRecord
  validates :name, presence: true
  validates :context, presence: true
end
