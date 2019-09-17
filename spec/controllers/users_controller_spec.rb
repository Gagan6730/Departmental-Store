require 'rails_helper'
RSpec.describe UsersController, :type => :controller do

  load "#{Rails.root}/db/seeds.rb"


  describe "GET new" do
    it "displays the sign in page for that" do
      get 'new'
      expect(response).to be_successful
      expect(response).to render_template(:new)
      # response.should_be_successful
      # expect(response).to render_views?()
    end
  end

  describe "POST signin" do
    it "user enters valid details" do
      post :signin, {:user => {"email" => "abc@gmail.com", "password" => "abc123"}}
      actual_user = assigns(:user)
      expect(actual_user.id).to_not eql(nil)
      expect(actual_user.id).to eql(actual_user.id)
      expect(actual_user.email).to eql("abc@gmail.com")
      expect(actual_user.password).to eql("abc123")
      expect(response).to redirect_to(billing_path)
      # expect(response).to render_template(:billing)
    end

    it "user enters invalid details" do
      post :signin, {:user => {"email" => "abc@gmail.com", "password" => "xyz123"}}
      expect(response).to render_template(:invalidlogin)
    end
  end


  describe "User Registers" do
    it "assigns newly created user to @user and store to @store and redirect to signin" do

      params = {:user =>  {
          "firstName" => "Nikhil", "lastName" => "Prasanna", "email" => "nikp@gmail.com", "password" => "whymynikphard",
          "password_confirmation" => "whymynikphard" }, :store => { "shopName" => "Dukaan", "registrationNumber" => "12345678", "locality" => "Yahan", "city" => "Wahan",
                                                                       "pin" => "111111"}}
      # store_Params = {:store => { "shopName" => "Dukaan", "registrationNumber" => "12345678", "locality" => "Yahan", "city" => "Wahan",
      #     "pin" => "111111"}}
      expected_user = User.new(params[:user])
      expected_store = Store.new(params[:store])

      post :create, params

      # send a get request at the desired location
      actual_user = assigns(:user)
      expect(actual_user.id).to_not eql(nil)
      expect(actual_user.id).to eql(actual_user.id)

      actual_store = assigns(:store)
      expect(actual_store.id).to_not eql(nil)
      expect(actual_store.id).to eql(actual_store.id)

      expect(actual_store.id).to eql(actual_user.id)

      expect(response).to redirect_to(new_user_path)

    end

  end

end