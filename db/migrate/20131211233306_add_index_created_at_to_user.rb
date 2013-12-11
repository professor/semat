class AddIndexCreatedAtToUser < ActiveRecord::Migration
  def change
    add_index :users, :created_at
    add_index :users, :updated_at
  end
end
