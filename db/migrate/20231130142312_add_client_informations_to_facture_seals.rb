class AddClientInformationsToFactureSeals < ActiveRecord::Migration[7.1]
  def change
    add_column :facture_seals, :client_name, :string
    add_column :facture_seals, :client_address, :text
    add_column :facture_seals, :client_city, :string
    add_column :facture_seals, :client_zip_code, :string
    add_column :facture_seals, :client_country, :string
    add_column :facture_seals, :client_business_number, :string
    add_column :facture_seals, :client_vat_number, :string
  end
end
