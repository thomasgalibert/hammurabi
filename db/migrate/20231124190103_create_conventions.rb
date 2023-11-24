class CreateConventions < ActiveRecord::Migration[7.1]
  def change
    create_table :conventions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dossier, null: false, foreign_key: true
      t.string :title
      t.date :date
      t.integer :forfait_cents

      t.timestamps
    end
  end
end
