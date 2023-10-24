class CreateDossiers < ActiveRecord::Migration[7.1]
  def change
    create_table :dossiers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :state
      t.text :description
      t.string :category
      t.string :court

      t.timestamps
    end
  end
end
