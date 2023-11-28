class AddUserIdToFactures < ActiveRecord::Migration[7.1]
  def change
    add_reference :factures, :user, null: false, foreign_key: true
  end
end
