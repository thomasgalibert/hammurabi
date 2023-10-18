class CreateLignes < ActiveRecord::Migration[7.1]
  def change
    create_table :lignes do |t|
      t.string :description
      t.integer :quantite
      t.integer :prix_unitaire_cents
      t.integer :reduction_cents
      t.float :tva
      t.integer :total_ht_cents
      t.integer :total_ttc_cents
      t.references :facturable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
