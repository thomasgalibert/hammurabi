class CreateFirmSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :firm_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :legal_name
      t.text :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :phone_number
      t.string :email
      t.string :business_number
      t.string :vat_number
      t.string :share_capital

      t.timestamps
    end
  end
end
