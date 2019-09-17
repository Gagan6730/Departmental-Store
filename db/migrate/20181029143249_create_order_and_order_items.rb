class CreateOrderAndOrderItems < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :customer, index:true
      t.belongs_to :user
      t.decimal :total
      t.string :date
    end

    create_table :order_items do |t|
      t.belongs_to :order, index:true
      t.belongs_to :catalog_item, index:true
      t.integer :quantity
    end
  end
end
