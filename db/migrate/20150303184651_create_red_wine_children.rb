class CreateRedWineChildren < ActiveRecord::Migration
  def change
    create_table :red_wine_children do |t|
      t.string :name
      t.integer :age

      t.timestamps null: false
    end
    add_index :red_wine_children, :name, unique: true
  end
end
