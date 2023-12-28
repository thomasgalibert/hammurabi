class AddBarNameToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :bar_name, :string
    add_column :contacts, :mailbox_number, :string
  end
end
