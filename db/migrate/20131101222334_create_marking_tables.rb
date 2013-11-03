class CreateMarkingTables < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :team_id
      t.integer :checklist_id
      t.integer :scribe_id
      t.boolean :checked

      t.timestamps
    end

    create_table :team_checklists do |t|
      t.integer :team_id
      t.integer :checklist_id
      t.integer :scribe_id

      t.timestamps
    end

    create_table :teams do |t|
      t.string :name
      t.integer :owner_id

      t.timestamps
    end
  end

end
