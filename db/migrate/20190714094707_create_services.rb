class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.belongs_to :seller
      t.string :title, null: false
      t.text :description
      t.monetize :price

      t.timestamps
    end
  end
end
