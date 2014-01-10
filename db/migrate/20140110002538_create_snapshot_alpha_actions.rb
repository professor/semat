class CreateSnapshotAlphaActions < ActiveRecord::Migration
  def change
    create_table :snapshot_alpha_actions do |t|
      t.integer :snapshot_alpha_id
      t.integer :snapshot_alpha_action_id #parent
      t.text :description
      t.integer :scribe_id
      t.string :state  #new, copy, done, deleted
      t.timestamps
    end
    add_index :snapshot_alpha_actions, :snapshot_alpha_id
    add_index :snapshot_alpha_actions, :snapshot_alpha_action_id
    add_index :snapshot_alpha_actions, :scribe_id
    add_index :snapshot_alpha_actions, :state

    remove_column :snapshot_alphas, :actions
  end
end
