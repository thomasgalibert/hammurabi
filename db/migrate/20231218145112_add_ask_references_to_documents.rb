class AddAskReferencesToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_reference :documents, :ask, null: true, foreign_key: true
  end
end
