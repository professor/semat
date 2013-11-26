class CreateSnapshots < ActiveRecord::Migration

  def change
    create_table :snapshots do |t|
      t.integer :team_id
      t.integer :order

      t.timestamps
    end

    add_index :snapshots, :team_id
    add_index :snapshots, [:team_id, :order], :unique => true

    create_table :snapshot_checklists do |t|
      t.integer :snapshot_id
      t.integer :checklist_id
      t.integer :scribe_id

      t.timestamps
    end
    add_index :snapshot_checklists, :snapshot_id
    add_index :snapshot_checklists, :checklist_id
    add_index :snapshot_checklists, :scribe_id
    add_index :snapshot_checklists, [:snapshot_id, :checklist_id], :unique => true

    create_table :snapshot_alphas do |t|
      t.integer :snapshot_id
      t.integer :alpha_id
      t.integer :scribe_id
      t.integer :current_state_id
      t.text    :notes,   :default => ""
      t.text    :actions, :default => ""

      t.timestamps
    end
    add_index :snapshot_alphas, :snapshot_id
    add_index :snapshot_alphas, :alpha_id
    add_index :snapshot_alphas, :scribe_id
    add_index :snapshot_alphas, :current_state_id
    add_index :snapshot_alphas, [:snapshot_id, :alpha_id], :unique => true


  end
end
