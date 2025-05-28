class AddTeamFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, default: "owner", null: false
    add_column :users, :team_id, :integer
    add_index :users, :team_id
    
    # Met à jour tous les utilisateurs existants pour être des "owner"
    reversible do |dir|
      dir.up do
        User.update_all(role: "owner")
      end
    end
  end
end
