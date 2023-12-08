class AddReferenceToConventions < ActiveRecord::Migration[7.1]
  def change
    add_column :conventions, :reference, :string
  end
end
