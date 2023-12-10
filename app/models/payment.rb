# -------------- SCHEMA INFORMATION --------------
# t.bigint "facture_id", null: false
# t.bigint "user_id", null: false
# t.integer "amount_cents"
# t.date "issued_date"
# t.string "mean"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# -----------------------------------------------

class Payment < ApplicationRecord
  belongs_to :facture
  belongs_to :user
  monetize :amount_cents

  after_save :update_facture_status
  after_destroy :update_facture

  validates :issued_date, :mean, presence: true

  MEANS = %w[card wire check cash other]

  private

  def update_facture_status
    facture.update_payment_status
  end
end
