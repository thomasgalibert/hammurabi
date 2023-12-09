# -------------- SCHEMA INFORMATION --------------
# t.bigint "facture_id", null: false
# t.bigint "user_id", null: false
# t.integer "amount_cents"
# t.date "issued_date"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# -----------------------------------------------

class Payment < ApplicationRecord
  belongs_to :facture, touch: true
  belongs_to :user
  monetize :amount_cents

  after_create :update_facture
  after_destroy :update_facture

  validates :issued_date, presence: true

  private

  def update_facture
    facture.save
  end
end
