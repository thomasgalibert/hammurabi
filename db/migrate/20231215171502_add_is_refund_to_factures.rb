class AddIsRefundToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :is_refund, :boolean, default: false
  end
end
