class StoreControllerController < ApplicationController
  def editStore
    if session.key? :current_store_id
      @changesMade = "null"
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)
    else
      redirect_to "/users/new"
    end


  end

  def performEdit

    if session.key? :current_store_id
      @changesMade = "false"
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)
      @user.firstName = params[:user][:firstName]
      @user.lastName = params[:user][:lastName]
      @store.locality = params[:store][:locality]
      @store.city = params[:store][:city]
      @store.pin = params[:store][:pin]
      begin
        @user.save
        @store.save
        @changesMade = "true"
        render 'editStore'
      rescue
        @changesMade = "false"
        render 'editStore'
      end
    else
      redirect_to "/users/new"
    end

  end

  def billing
    if session.key? :current_store_id
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)
    else
      redirect_to "/users/new"
    end
  end
end
