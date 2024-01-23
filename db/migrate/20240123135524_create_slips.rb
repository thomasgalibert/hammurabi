class CreateSlips < ActiveRecord::Migration[7.1]
  def change
    create_table :slips do |t|
      t.references :dossier, null: false, foreign_key: true
      t.text :recipient
      t.string :date

      t.timestamps
    end
  end
end
