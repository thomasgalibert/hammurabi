class CreateConclusions < ActiveRecord::Migration[7.1]
  def change
    create_table :conclusions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dossier, null: false, foreign_key: true
      t.date :date
      t.string :name

      t.timestamps
    end
  end
end
