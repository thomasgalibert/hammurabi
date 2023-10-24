class CreateDossierContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :dossier_contacts do |t|
      t.references :dossier, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
