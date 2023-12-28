class RenameRbNumberToDossiers < ActiveRecord::Migration[7.1]
  def change
    rename_column :dossiers, :rb_number, :rg_number
  end
end
