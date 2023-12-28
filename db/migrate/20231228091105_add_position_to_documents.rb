class AddPositionToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :position, :integer
  end
end
