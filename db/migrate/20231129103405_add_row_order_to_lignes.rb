class AddRowOrderToLignes < ActiveRecord::Migration[7.1]
  def change
    add_column :lignes, :row_order, :integer
  end
end
