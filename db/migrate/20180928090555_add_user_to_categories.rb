class AddUserToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :user_id, :integer
    add_reference :categories, :user, index: true, foreign_key: true
  end
end
