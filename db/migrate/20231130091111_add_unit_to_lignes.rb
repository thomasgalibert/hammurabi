class AddUnitToLignes < ActiveRecord::Migration[7.1]
  def change
    add_column :lignes, :unit, :string
  end
end
