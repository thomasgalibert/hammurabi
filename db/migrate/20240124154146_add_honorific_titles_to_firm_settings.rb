class AddHonorificTitlesToFirmSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :firm_settings, :honorific_titles, :text
  end
end
