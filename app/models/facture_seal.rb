# SCHEMA
# t.bigint "facture_id", null: false
# t.string "emetteur_legal_name"
# t.text "emetteur_address"
# t.string "emetteur_city"
# t.string "emetteur_zip_code"
# t.string "emetteur_country"
# t.string "emetteur_business_number"
# t.string "emetteur_vat_number"
# t.string "emetteur_share_capital"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "client_name"
# t.text "client_address"
# t.string "client_city"
# t.string "client_zip_code"
# t.string "client_country"
# t.string "client_business_number"
# t.string "client_vat_number"
# t.index ["facture_id"], name: "index_facture_seals_on_facture_id"
# -> END SCHEMA

class FactureSeal < ApplicationRecord
  belongs_to :facture

  def populate_with_facture(facture)
    self.emetteur_legal_name = facture.emetteur.firm_setting.legal_name
    self.emetteur_address = facture.emetteur.firm_setting.address
    self.emetteur_city = facture.emetteur.firm_setting.city
    self.emetteur_zip_code = facture.emetteur.firm_setting.zip_code
    self.emetteur_country = facture.emetteur.firm_setting.country
    self.emetteur_business_number = facture.emetteur.firm_setting.business_number
    self.emetteur_vat_number = facture.emetteur.firm_setting.vat_number
    self.emetteur_share_capital = facture.emetteur.firm_setting.share_capital

    self.client_name = facture.contact.name_with_company
    self.client_address = facture.contact.address
    self.client_city = facture.contact.city
    self.client_zip_code = facture.contact.zip_code
    self.client_country = facture.contact.country
    self.client_business_number = facture.contact.business_number
    self.client_vat_number = facture.contact.vat_number
  end
end
