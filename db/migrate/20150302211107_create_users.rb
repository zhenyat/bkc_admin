class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :role, index: true
      t.string     :last_name,    null: false
      t.string     :first_name,   null: false
      t.date       :birthday
      t.string     :email,        null: false
      t.string     :phone
      t.string     :password_digest
      t.string     :remember_digest
      t.integer    :status, default: 0

      t.timestamps null: false
    end
    add_foreign_key :users, :roles
    add_index       :users, :email, unique: true
  end
end
