class RemoveLockedToFactures < ActiveRecord::Migration[7.1]
  def change
    remove_column :factures, :locked, :boolean
  end
end
