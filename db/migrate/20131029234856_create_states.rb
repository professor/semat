class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.integer :order
      t.integer :alpha_id

      t.timestamps
    end
  end
end
