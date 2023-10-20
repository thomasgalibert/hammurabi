class ChangeColumnLockOfFactures < ActiveRecord::Migration[7.1]
  def change
    rename_column :factures, :lock, :locked
  end
end
