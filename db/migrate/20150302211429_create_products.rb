class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :title
      t.text    :description
      t.decimal :price,  default: 0.0
      t.boolean :stock,  default: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
