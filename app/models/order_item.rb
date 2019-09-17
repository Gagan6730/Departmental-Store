class OrderItem < ActiveRecord::Base
  belongs_to :catalog_item
  belongs_to :order
end
