class AddDossierReferencesToFactures < ActiveRecord::Migration[7.1]
  def change
    add_reference :factures, :dossier, null: false, foreign_key: true
  end
end
