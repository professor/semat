class AddTeamIdToAction < ActiveRecord::Migration
  def change
    add_column :actions, :team_id, :integer
    add_column :actions, :alpha_id, :integer

    add_index :actions, :team_id
    add_index :actions, :alpha_id
  end

end
