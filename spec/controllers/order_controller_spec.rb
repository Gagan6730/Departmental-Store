require 'rails_helper'
RSpec.describe OrderController, :type => :controller do

  load "#{Rails.root}/db/seeds.rb"


  describe "GET index" do
    it "displays the login page if user is not logged in" do
      get 'index'
      expect(response).to redirect_to("/users/new")
    end

    it "shows orders if user is logged in" do
      session[:current_store_id] = 1
      get 'index'
      store_value_set = assigns(:user)
      expect(store_value_set).to eq(User.find(1))
      expect(assigns(:store)).to eq(Store.find(1))
      expect(assigns(:orders)).to_not be_empty
      expect(response).to render_template(:index)
    end

  end

  describe "#filter_orders" do
    it "returns all orders if query is empty" do
      all_orders = @controller.filter_orders(Order.all, "")
      expect(all_orders.count).to eq(Order.all.count)
    end

    it "filters orders if query is not empty" do
      all_orders = @controller.filter_orders(Order.all, "something_that_doesn't_exist")
      expect(all_orders.count).to eq(0)
    end

    it "returns empty list if no orders are present and query is empty" do
      all_orders = @controller.filter_orders([], "")
      expect(all_orders.count).to eq(0)
    end

    it "returns empty list if no orders are present and query is not empty" do
      all_orders = @controller.filter_orders([], "asdf")
      expect(all_orders.count).to eq(0)
    end
  end

end
