class CreateUsers < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'users'
      drop_table :users
    end
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :password
      t.string :email

      t.timestamps null: false
    end
  end
end
