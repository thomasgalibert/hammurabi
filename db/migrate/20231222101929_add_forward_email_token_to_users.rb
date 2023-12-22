class AddForwardEmailTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :forward_email_token, :string
  end
end
