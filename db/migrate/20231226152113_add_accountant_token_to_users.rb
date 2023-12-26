class AddAccountantTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :accountant_token, :string
  end
end
