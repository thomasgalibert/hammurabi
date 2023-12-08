class AddReferenceToDossiers < ActiveRecord::Migration[7.1]
  def change
    add_column :dossiers, :reference, :string
  end
end
