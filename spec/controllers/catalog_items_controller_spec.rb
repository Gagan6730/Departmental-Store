require 'rails_helper'
RSpec.describe CatalogItemsController, :type => :controller do

  load "#{Rails.root}/db/seeds.rb"


  describe "clear cart" do
    it "displays the login page if user is not logged in" do
      post 'clearCart'
      expect(response).to redirect_to("/users/new")
    end

    it "clears the cart if any items are present in it" do
      session[:current_store_id] = 1
      session[:cart_items] = [1]
      response = post "clearCart"
      expect(session[:cart_items]).to be_empty
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to eq([])
    end

    it "leaves cart empty if cart had 0 items" do
      session[:current_store_id] = 1
      session[:cart_items] = []
      response = post "clearCart"
      expect(session[:cart_items]).to be_empty
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to eq([])
    end

  end

  describe "addToCart" do
    it "displays the login page if user is not logged in" do
      post 'addToCart'
      expect(response).to redirect_to("/users/new")
    end

    it "adds the item to session when initial cart is empty" do
      session[:current_store_id] = 1
      session[:cart_items] = []
      params = {}
      params[:selected_items] = [1]
      response = post :addToCart, params, session
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(1)
      expect(session[:cart_items].count).to eq(1)
      expect(assigns(:cart_items).count).to eq(1)
      expect(assigns(:new_items).count).to eq(1)
    end

    it "adds the item to session when initial cart is not empty" do
      session[:current_store_id] = 1
      session[:cart_items] = [2]
      params = {}
      params[:selected_items] = [1]
      response = post :addToCart, params, session
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(1)
      expect(session[:cart_items].count).to eq(2)
      expect(assigns(:cart_items).count).to eq(2)
      expect(assigns(:new_items).count).to eq(1)
    end

    it "doesn't add the item to session when new items are nil" do
      session[:current_store_id] = 1
      session[:cart_items] = [2]
      params = {}
      params[:selected_items] = nil
      response = post :addToCart, params, session
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(0)
      expect(session[:cart_items].count).to eq(1)
      expect(assigns(:cart_items).count).to eq(1)
      expect(assigns(:new_items).count).to eq(0)
    end

    it "doesn't add the item to session when new items are empty" do
      session[:current_store_id] = 1
      session[:cart_items] = [2]
      params = {}
      params[:selected_items] = []
      response = post :addToCart, params, session
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(0)
      expect(session[:cart_items].count).to eq(1)
      expect(assigns(:cart_items).count).to eq(1)
      expect(assigns(:new_items).count).to eq(0)
    end
  end

end
