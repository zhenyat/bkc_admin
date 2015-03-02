class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string  :name
      t.string  :title
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
