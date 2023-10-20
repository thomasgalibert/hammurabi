class ChangeTvaCentsToLignes < ActiveRecord::Migration[7.1]
  def change
    # Change column tva_cents to total_tva_cents
    rename_column :lignes, :tva_cents, :total_tva_cents
  end
end
