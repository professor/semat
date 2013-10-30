class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :name
      t.integer :order
      t.integer :state_id

      t.timestamps
    end
  end
end
