class AddMainToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :main, :boolean, default: false
  end
end
