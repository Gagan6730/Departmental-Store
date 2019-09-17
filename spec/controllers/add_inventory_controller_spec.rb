require 'rails_helper'
RSpec.describe AddInventoryController, :type => :controller do

  load "#{Rails.root}/db/seeds.rb"

  describe "GET new" do
    it "user is not logged in, redirect to signIn" do
      get 'new'
      expect(response).to redirect_to("/users/new")
    end

    it "user logged in, models get assigned accordingly" do
      session[:current_store_id] = 1
      get 'new'
      @user = User.find(1)
      @store = Store.find(1)
      @all_categories = []
      @all_categories.push Category.find(1)
      @all_categories.push Category.find(2)
      @all_categories.push Category.find(3)
      @all_categories.push Category.find(4)
      @all_categories.push Category.find(5)
      expect(assigns(:categories)).to eql(@all_categories)
      expect(assigns(:store)).to eq(Store.find(1))
      expect(assigns(:user)).to eq(User.find(1))
    end

    it "user logged in, render page for new item" do
      session[:current_store_id] = 1
      get 'new'
      expect(response).to render_template(:new)
    end
  end

  describe "PUT create" do

    let!(:itemAtt) do
      {name: "Pizza", qty: 10, price: 300, category_id: 2}
    end

    let!(:itemAttInvalid) do
      {name: nil, qty: nil, price: nil, category_id: nil} #invalid category
    end

    it "user is not logged in, redirect to signIn" do
      put 'create'
      expect(response).to redirect_to("/users/new")
    end

    describe "Valid arguments" do
      it "inventory created on valid args" do
        session[:current_store_id] = 1
        post :create, {:catalog_item => itemAtt}
        expect(assigns(:changesMade)).to eql("true")
        expect(assigns(:store)).to eq(Store.find(1))
        expect(assigns(:user)).to eq(User.find(1))
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:store)).to be_a(Store)
        expect(assigns(:add_catalogue_item)).to be_a(CatalogItem)
        expect(assigns(:add_catalogue_item)).to be_persisted

      end

      it "inventory created on valid args redirected to inventory page" do
        session[:current_store_id] = 1
        post :create, {:catalog_item => itemAtt}
        expect(assigns(:changesMade)).to eql("true")
        expect(response).to redirect_to("/dashboard/inventory?changes_made=true")
      end
    end

    describe "Invalid arguments" do
      it "invalid args, causes error" do
        session[:current_store_id] = 1
        post :create, {:catalog_item => itemAttInvalid}
        expect(assigns(:add_catalogue_item)).to be_a(CatalogItem)
      end

      it "invalid args, redirects to the inventory page" do
        session[:current_store_id] = 1
        post :create, {:catalog_item => itemAttInvalid}
        expect(response).to redirect_to("/dashboard/inventory?changes_made=true")
      end

    end

  end

end