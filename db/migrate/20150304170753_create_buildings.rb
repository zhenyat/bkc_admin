class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.references :building_type, index: true
      t.string :name
      t.string :title
      t.integer :status

      t.timestamps null: false
    end
    add_foreign_key :buildings, :building_types
  end
end
