class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :shopName
      t.string :registrationNumber
      t.string :locality
      t.string :city
      t.integer :pin
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :stores, :user_id
  end
end
