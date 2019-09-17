# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category1 = Category.create({:category_name => "Toothpaste", :user_id => 0})
category2 = Category.create({:category_name => "Fast Food", :user_id => 0})
category3 = Category.create({:category_name => "Beverages", :user_id => 0})
category4 = Category.create({:category_name => "Furniture", :user_id => 0})
category5 = Category.create({:category_name => "Decorations", :user_id => 0})
category6 = Category.create({:category_name => "Deodorant", :user_id => 1})

item1 = CatalogItem.create({:name => "Colgate 60g", :price => 60.0, :qty=> 50})
item2 = CatalogItem.create({:name => "Colgate 120g", :price => 100.0, :qty=> 50})
item3 = CatalogItem.create({:name => "Pepsodent 60g", :price => 60.0, :qty=> 50})
item4 = CatalogItem.create({:name => "Pepsodent 100g", :price => 90.0, :qty=> 30})
item1.category = category1
item2.category = category1
item3.category = category1
item4.category = category1

item5 = CatalogItem.create({:name => "Lays American Style Cream & Onion 30g", :price => 20.0, :qty=> 100})
item6 = CatalogItem.create({:name => "Lays Masala 30g", :price => 20.0, :qty=> 100})
item7 = CatalogItem.create({:name => "Lays Tangy Tomato 30g", :price => 20.0, :qty=> 100})
item8 = CatalogItem.create({:name => "Lays American Style Cream & Onion 60g", :price => 40.0, :qty=> 100})
item9 = CatalogItem.create({:name => "Lays Masala 60g", :price => 40.0, :qty=> 100})
item10 = CatalogItem.create({:name => "Lays Tangy Tomato 60g", :price => 40.0, :qty=> 100})
item5.category = category2
item6.category = category2
item7.category = category2
item8.category = category2
item9.category = category2
item10.category = category2


item11 = CatalogItem.create({:name => "Pepsi 600ml", :price => 35, :qty=> 50})
item12 = CatalogItem.create({:name => "Pepsi 2L", :price => 75.0, :qty=> 50})
item11.category = category3
item12.category = category3

item13 = CatalogItem.create({:name => "Chair", :price => 900.0, :qty=> 10})
item14 = CatalogItem.create({:name => "Table", :price => 1990.0, :qty=> 5})
item13.category = category4
item14.category = category4

item15 = CatalogItem.create({:name => "Desk Lamp", :price => 750.0, :qty=> 1})
item15.category = category5


testUser = User.create firstName: "Nitin", lastName: "Kumar", email: "abc@gmail.com", password: "abc123"
testUser2 = User.create firstName: "Akshat", lastName: "Sharda", email: "abc2@gmail.com", password: "abc123"
testStore = Store.create shopName: "BB", registrationNumber: "ABC123", locality: "East zone", city: "ND", pin: 110067
testStore2 = Store.create shopName: "CC", registrationNumber: "ABC456", locality: "West zone", city: "BB", pin: 110068
testUser.store = testStore
testUser2.store = testStore2

category1.user = testUser
category2.user = testUser
category3.user = testUser
category4.user = testUser
category5.user = testUser
category6.user = testUser2

item1.user = testUser
item2.user = testUser
item3.user = testUser
item4.user = testUser
item5.user = testUser
item6.user = testUser
item7.user = testUser
item8.user = testUser
item9.user = testUser
item10.user = testUser
item11.user = testUser
item12.user = testUser
item13.user = testUser
item14.user = testUser
item15.user = testUser2


category1.save
category2.save
category3.save
category4.save
category5.save
category6.save

item1.save
item2.save
item3.save
item4.save
item5.save
item6.save
item7.save
item8.save
item9.save
item10.save
item11.save
item12.save
item13.save
item14.save
item15.save


order_item_1 = OrderItem.create catalog_item: item1, quantity: 5
order_item_2 = OrderItem.create catalog_item: item1, quantity: 5
order_item_3 = OrderItem.create catalog_item: item3, quantity: 5
order_item_4 = OrderItem.create catalog_item: item4, quantity: 5
order_1 = Order.create user: testUser
order_1.order_items = [order_item_1, order_item_2, order_item_3, order_item_4]