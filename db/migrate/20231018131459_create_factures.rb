class CreateFactures < ActiveRecord::Migration[7.1]
  def change
    create_table :factures do |t|
      t.integer :total_ht_cents
      t.integer :total_ttc_cents
      t.date :date
      t.integer :numero
      t.string :state

      t.timestamps
    end
  end
end
