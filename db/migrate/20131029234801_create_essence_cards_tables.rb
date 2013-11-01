class CreateEssenceCardsTables < ActiveRecord::Migration
  def change
    create_table :alphas do |t|
      t.string :name
      t.string :color
      t.string :concern
      t.string :definition
      t.text :description
      t.integer :order
      t.integer :essence_version_id

      t.timestamps
    end

    create_table :states do |t|
      t.string :name
      t.integer :order
      t.integer :alpha_id

      t.timestamps
    end

    create_table :checklists do |t|
      t.string :name
      t.integer :order
      t.integer :state_id

      t.timestamps
    end

    create_table :essence_versions do |t|
      t.string :name

      t.timestamps
    end
  end
end
