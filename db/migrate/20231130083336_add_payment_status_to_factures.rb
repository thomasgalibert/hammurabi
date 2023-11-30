class AddPaymentStatusToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :payment_status, :string
  end
end
