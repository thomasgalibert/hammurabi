class AddTermsToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :date_fin_validite, :date
  end
end
