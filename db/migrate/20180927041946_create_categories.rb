class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_name
      t.integer :category_id
      t.string :user_id
      t.timestamps null: false
    end
  end
end
