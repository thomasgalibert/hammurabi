# Schema information for the Payment model. Defines database columns and their types.
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
  
  def vat_evaluated_amount
    ( amount_cents / 100 ) - ( amount_cents / (1 + rate_vat_of_facture) / 100.0 )
  end

  private

  def update_facture_status
    facture.update_payment_status
  end

  def rate_vat_of_facture
    (facture.total_tva / facture.total_ttc.to_f)
  end
end
