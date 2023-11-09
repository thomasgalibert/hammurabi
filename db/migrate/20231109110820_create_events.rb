class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dossier, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :kind
      t.datetime :date

      t.timestamps
    end
  end
end
