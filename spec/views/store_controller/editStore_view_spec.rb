
require 'rails_helper'

RSpec.describe "store_controller/editStore", :type => :view do
  before(:each) do
    @store = Store.find(1)
    @str = Store.find(1)
    @user =  User.find(@store.user_id)
    @usr = User.find(@store.user_id)

  end


  it "renders edit Controller form" do
    render
    assert_select"form[action=?][method=?]", "/dashboard/storedetails/","post" do
      assert_select "input#store_registrationNumber[value=?]" , @str.registrationNumber
      assert_select "input#store_registrationNumber[name=?]", "store[registrationNumber]"

      assert_select "input#store_shopName[value=?]" , @str.shopName
      assert_select "input#store_shopName[name=?]", "store[shopName]"

      assert_select "input#user_email[value=?]" , @usr.email
      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_firstName[value=?]" , @usr.firstName
      assert_select "input#user_firstName[name=?]", "user[firstName]"

      assert_select "input#user_lastName[value=?]" , @usr.lastName
      assert_select "input#user_lastName[name=?]", "user[lastName]"

      assert_select "input#store_city[value=?]" , @str.city
      assert_select "input#store_city[name=?]", "store[city]"

      assert_select "input#store_locality[value=?]" , @str.locality
      assert_select "input#store_locality[name=?]", "store[locality]"

      assert_select "input#store_pin[value=?]" , @str.pin
      assert_select "input#store_pin[name=?]", "store[pin]"
    end
  end
end
