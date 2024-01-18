class AddIcalTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :ical_token, :string
  end
end
