class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.references :todoable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :done, default: false
      t.date :due_at

      t.timestamps
    end
  end
end
