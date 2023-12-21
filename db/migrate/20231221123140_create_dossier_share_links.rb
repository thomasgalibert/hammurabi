class CreateDossierShareLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :dossier_share_links do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :dossier, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
