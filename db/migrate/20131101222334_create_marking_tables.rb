class CreateMarkingTables < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :team_id
      t.integer :checklist_id
      t.integer :scribe_id
      t.boolean :checked

      t.timestamps
    end
    add_index :logs, :team_id
    add_index :logs, :checklist_id
    add_index :logs, :scribe_id

    create_table :team_checklists do |t|
      t.integer :team_id
      t.integer :checklist_id
      t.integer :scribe_id

      t.timestamps
    end
    add_index :team_checklists, :team_id
    add_index :team_checklists, :checklist_id
    add_index :team_checklists, :scribe_id
    add_index :team_checklists, [:team_id, :checklist_id]

    create_table :teams do |t|
      t.string :name
      t.integer :owner_id

      t.timestamps
    end
    add_index :teams, :owner_id
  end

end
