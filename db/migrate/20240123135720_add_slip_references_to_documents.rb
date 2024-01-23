class AddSlipReferencesToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_reference :documents, :slip, null: true, foreign_key: true
  end
end
