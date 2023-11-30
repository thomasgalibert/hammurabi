class AddBackupNumberToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :backup_number, :string
  end
end
