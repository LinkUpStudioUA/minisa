class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :password_digest, null: false
      t.string :email, null: false
      t.string :role, null: false
      t.string :name, null: false
      t.string :location
      t.text :avatar_data
      t.float :commission_percentage
      t.monetize :balance

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
