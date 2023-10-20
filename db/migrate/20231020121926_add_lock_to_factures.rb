class AddLockToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :lock, :boolean, default: false
  end
end
