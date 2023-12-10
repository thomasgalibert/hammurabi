class AddMeanToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :mean, :string
  end
end
