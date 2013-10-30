class CreateAlphas < ActiveRecord::Migration
  def change
    create_table :alphas do |t|
      t.string :name
      t.string :color
      t.string :concern
      t.integer :order

      t.timestamps
    end
  end
end
