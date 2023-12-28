class AddBarNameToFirmSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :firm_settings, :bar_name, :string
    add_column :firm_settings, :mailbox_number, :string
  end
end
