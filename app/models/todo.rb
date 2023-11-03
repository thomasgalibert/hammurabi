class Todo < ApplicationRecord
  belongs_to :todoable, polymorphic: true
  belongs_to :user

  scope :completed, -> { where(done: true) }
  scope :incomplete, -> { where(done: false) }
  scope :lasts, -> (limit) { order(created_at: :desc).limit(limit) }

  validates :name, presence: true
  validates :done, inclusion: { in: [true, false] }
end
