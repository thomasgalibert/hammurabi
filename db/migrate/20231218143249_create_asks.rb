class CreateAsks < ActiveRecord::Migration[7.1]
  def change
    create_table :asks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dossier, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
