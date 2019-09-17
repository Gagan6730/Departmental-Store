
require 'rails_helper'

RSpec.describe "users/new", :type => :view do
  before(:each) do
    assign(:user, User.new(
        :firstName => "Ashutosh",
        :lastName => "Gupta",
        :email => "ashu@ds.com"

    ))
    assign(:store, Store.new(
        :shopName => "DS Store",
        :registrationNumber => 123,
        :locality => "Rohini Sector 5",
        :city => "Rohini",
        :pin => 110085
    ))
  end

  it "renders new signup student form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_firstName[name=?]", "user[firstName]"
      assert_select "input#user_lastName[name=?]", "user[lastName]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#store_shopName[name=?]", "store[shopName]"
      assert_select "input#store_registrationNumber[name=?]", "store[registrationNumber]"
      assert_select "input#store_locality[name=?]", "store[locality]"
      assert_select "input#store_city[name=?]", "store[city]"
      assert_select "input#store_pin[name=?]", "store[pin]"
    end

  end
  it "renders new signup student form" do
    render
    assert_select"form[action=?][method=?]", users_signin_path,"post" do
      assert_select "input#user_email[name=?]", "user[email]"

    end
  end
end
