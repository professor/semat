class AddHiddenStateCards < ActiveRecord::Migration
  def change
    add_column :states, :visible, :boolean, :default => true
    add_column :states, :number, :string
    add_index :states, :visible
  end

end
