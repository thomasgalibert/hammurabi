class AddBirthdayToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :birthday, :date
    add_column :contacts, :nationality, :string
    add_column :contacts, :job, :string
  end
end
