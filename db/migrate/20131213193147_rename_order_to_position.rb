class RenameOrderToPosition < ActiveRecord::Migration
  def change
    rename_column :alphas, :order, :position
    rename_column :checklists, :order, :position
    rename_column :snapshots, :order, :position
    rename_column :states, :order, :position
  end

  #   add_index "snapshots", ["team_id", "order"], name: "index_snapshots_on_team_id_and_order", unique: true, using: :btree


end
