class CreateBuildingTypes < ActiveRecord::Migration
  def change
    create_table :building_types do |t|
      t.string :name
      t.string :title
      t.integer :status

      t.timestamps null: false
    end
  end
end
