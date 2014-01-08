class AddEssenceVersionToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :essence_version_id, :integer
    add_index :teams, :essence_version_id
  end
end

# To update existing data run
# Team.all.each do |v| v.update_attributes(:essence_version_id => 1) end