class AddViewedAtToDossiers < ActiveRecord::Migration[7.1]
  def change
    add_column :dossiers, :viewed_at, :datetime
  end
end
