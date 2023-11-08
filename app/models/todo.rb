# == Schema definition
# t.string "todoable_type", null: false
# t.bigint "todoable_id", null: false
# t.bigint "user_id", null: false
# t.string "name"
# t.boolean "done", default: false
# t.date "due_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["todoable_type", "todoable_id"], name: "index_todos_on_todoable"
# t.index ["user_id"], name: "index_todos_on_user_id"
# == Schema end

class Todo < ApplicationRecord
  belongs_to :todoable, polymorphic: true
  belongs_to :user

  scope :completed, -> { where(done: true) }
  scope :incomplete, -> { where(done: false) }
  scope :lasts, -> (limit) { order(due_at: :desc, created_at: :desc).limit(limit) }

  validates :name, presence: true
  validates :done, inclusion: { in: [true, false] }
end
