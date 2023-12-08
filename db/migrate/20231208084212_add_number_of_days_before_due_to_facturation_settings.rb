class AddNumberOfDaysBeforeDueToFacturationSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :facturation_settings, :number_of_days_before_due, :integer, default: 15
  end
end
