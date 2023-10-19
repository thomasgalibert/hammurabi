class ChangeColumnReductionToLignes < ActiveRecord::Migration[7.1]
  def change
    # Remove column reduction_cents from table lignes
    remove_column :lignes, :reduction_cents, :integer
    # Add column recution to table lignes
    add_column :lignes, :reduction, :float
  end
end
