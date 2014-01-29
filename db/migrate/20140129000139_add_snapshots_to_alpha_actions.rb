class AddSnapshotsToAlphaActions < ActiveRecord::Migration

  def change
    rename_table :snapshot_alpha_actions, :actions

    create_table :snapshot_alpha_actions do |t|
      t.integer :snapshot_alpha_id
      t.integer :action_id

      t.timestamps
    end

    add_index :snapshot_alpha_actions, :snapshot_alpha_id
    add_index :snapshot_alpha_actions, :action_id
  end
end
