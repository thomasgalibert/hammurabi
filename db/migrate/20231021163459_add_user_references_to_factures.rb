class AddUserReferencesToFactures < ActiveRecord::Migration[7.1]
  def change
    add_reference :factures, :emetteur, null: false, foreign_key: { to_table: :users }
  end
end
