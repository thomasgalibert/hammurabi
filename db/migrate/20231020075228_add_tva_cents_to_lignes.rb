class AddTvaCentsToLignes < ActiveRecord::Migration[7.1]
  def change
    add_column :lignes, :tva_cents, :integer
  end
end
