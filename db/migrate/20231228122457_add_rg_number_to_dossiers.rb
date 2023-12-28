class AddRgNumberToDossiers < ActiveRecord::Migration[7.1]
  def change
    add_column :dossiers, :rb_number, :string
  end
end
