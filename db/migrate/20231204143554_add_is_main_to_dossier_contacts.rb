class AddIsMainToDossierContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :dossier_contacts, :is_main, :boolean, default: false
  end
end
