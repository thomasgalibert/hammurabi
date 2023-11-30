class AddCurrencyToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :currency, :string
  end
end
