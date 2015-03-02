class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :role, index: true
      t.string     :last_name
      t.string     :first_name
      t.date       :birthday
      t.string     :email
      t.string     :phone
      t.string     :password_digest
      t.string     :remember_digest
      t.integer    :status, default: 0

      t.timestamps null: false
    end
    add_foreign_key :users, :roles
  end
end
