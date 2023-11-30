class AddOrderReferenceToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :order_reference, :string
  end
end
