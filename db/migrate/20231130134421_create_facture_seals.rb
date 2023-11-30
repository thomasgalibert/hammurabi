class CreateFactureSeals < ActiveRecord::Migration[7.1]
  def change
    create_table :facture_seals do |t|
      t.references :facture, null: false, foreign_key: true
      t.string :emetteur_legal_name
      t.text :emetteur_address
      t.string :emetteur_city
      t.string :emetteur_zip_code
      t.string :emetteur_country
      t.string :emetteur_business_number
      t.string :emetteur_vat_number
      t.string :emetteur_share_capital

      t.timestamps
    end
  end
end
