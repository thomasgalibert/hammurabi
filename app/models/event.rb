# == Schema Definition
# t.bigint "user_id", null: false
# t.bigint "dossier_id", null: false
# t.string "title"
# t.text "description"
# t.string "kind"
# t.datetime "date"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["dossier_id"], name: "index_events_on_dossier_id"
# t.index ["user_id"], name: "index_events_on_user_id"
# == Schema end


class Event < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :dossier

  # Validations
  validates :title, :date, presence: true

  default_scope { order(date: :desc) }

  scope :hearings, -> { where(kind: ["hearing", "conciliation_hearing", "jugment_hearing"]) }
  scope :others, -> { where.not(kind: ["hearing", "conciliation_hearing", "jugment_hearing"]) }

  KINDS = [
    "meeting",
    "signature",
    "hearing",
    "conciliation_hearing",
    "judgment_hearing",
    "expertise",
    "other"
  ]

  KINDS_HEARING = [
    "hearing",
    "conciliation_hearing",
    "judgment_hearing"
  ]

  KINDS_OTHERS = [
    "meeting",
    "signature",
    "expertise",
    "other"
  ]
end
