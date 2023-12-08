class AddConventionReferencesToFactures < ActiveRecord::Migration[7.1]
  def change
    add_reference :factures, :convention, null: true, foreign_key: true
  end
end
