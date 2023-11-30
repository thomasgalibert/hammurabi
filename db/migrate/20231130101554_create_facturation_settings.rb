class CreateFacturationSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :facturation_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :tva_standard
      t.integer :first_invoice_number

      t.timestamps
    end
  end
end
