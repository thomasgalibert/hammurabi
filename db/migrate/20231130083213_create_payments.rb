class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :facture, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :amount_cents
      t.date :issued_date

      t.timestamps
    end
  end
end
