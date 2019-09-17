require 'rails_helper'
RSpec.describe StoreControllerController, :type => :controller do

  load "#{Rails.root}/db/seeds.rb"


  describe "GET editStore" do
    it "user is not logged in, redirect to signIn" do
      get 'editStore'
      expect(response).to redirect_to("/users/new")
    end

    it "user logged in, he sees the edit store page for his store" do
      session[:current_store_id] = 1
      get 'editStore'
      expect(assigns(:changesMade)).to eql("null")
      expect(assigns(:store)).to eq(Store.find(1))
      expect(assigns(:user)).to eq(User.find(1))
    end

    it "user logged in, renders editStore" do
      session[:current_store_id] = 1
      get 'editStore'
      expect(response).to render_template(:editStore)
    end

  end

  describe "GET billing" do
    it "user is not logged in, redirect to signIn" do
      get 'billing'
      expect(response).to redirect_to("/users/new")
    end

    it "user logged in, he sees the billing page for his store" do
      session[:current_store_id] = 1
      get 'billing'
      expect(assigns(:store)).to eq(Store.find(1))
      expect(assigns(:user)).to eq(User.find(1))
      expect(response).to render_template(:billing)
    end

    it "user logged in, renders billing" do
      session[:current_store_id] = 1
      get 'billing'
      expect(response).to render_template(:billing)
    end

  end

  describe "PUT performEdit" do

    let!(:userAtt) do
      {firstName: "ABC", lastName: "XYZ"}
    end

    let!(:storeAtt) do
      {locality: "JKL" , city: "IOP" , pin: "110000"}
    end

    it "user is not logged in, redirect to signIn" do
      put 'performEdit', :user => userAtt, :store => storeAtt
      expect(response).to redirect_to("/users/new")
    end

    it "user sees his/her info" do
      session[:current_store_id] = 1
      put 'performEdit', :user => userAtt, :store => storeAtt
      expect(assigns(:changesMade)).to eql("true")
      expect(assigns(:store)).to eq(Store.find(1))
      expect(assigns(:user)).to eq(User.find(1))
    end

    it "when user updates the valid store info, Model gets updated" do
      session[:current_store_id] = 1
      put 'performEdit', :user => userAtt, :store => storeAtt
      @user = User.find(1)
      @store = Store.find(1)
      expect(@user.firstName).to eql(userAtt[:firstName])
      expect(@user.lastName).to eql(userAtt[:lastName])
      expect(@store.locality).to eql(storeAtt[:locality])
      expect(@store.city).to eql(storeAtt[:city])
      expect(@store.pin).to eql(storeAtt[:pin].to_i)
    end

    it "after update, renders editStore" do
      session[:current_store_id] = 1
      put 'performEdit', :user => userAtt, :store => storeAtt
      expect(response).to render_template(:editStore)
    end

  end

end