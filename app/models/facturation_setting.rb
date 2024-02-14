# SCHEMA
# t.bigint "user_id", null: false
# t.decimal "tva_standard", precision: 10
# t.integer "first_invoice_number"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "default_payment_link"
# t.integer "number_of_days_before_due", default: 15
# t.index ["user_id"], name: "index_facturation_settings_on_user_id"
# -> END SCHEMA


class FacturationSetting < ApplicationRecord
  belongs_to :user
  has_rich_text :conditions_generales
  has_rich_text :conditions_paiement
  has_one_attached :logo

  validates :tva_standard, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :first_invoice_number, numericality: { greater_than_or_equal_to: 0 }

  validates :logo, 
            content_type: { 
              in: ['image/jpeg'], 
              message: "Le format du fichier doit être au format jpeg"}, 
            size: { 
              less_than: 1.megabytes , 
              message: "La taille du fichier ne doit pas dépasser 1 Mo" }

  validate :check_if_factures_achived_exists

  def check_if_factures_achived_exists
    if self.first_invoice_number_changed? && self.user.factures.nodraft.any?
      errors.add(:first_invoice_number, I18n.t('facturation_settings.errors.first_invoice_number'))
    end
  end

  def is_complete?
    self.tva_standard.present? && self.first_invoice_number.present?
  end

end
