class ChangeTypeColumnDateFromSlips < ActiveRecord::Migration[7.1]
  def change
    remove_column :slips, :date
    add_column :slips, :date, :date
  end
end
