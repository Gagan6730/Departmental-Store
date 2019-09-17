class UsersController < ApplicationController
  def new
    @user = User.new
    @store = Store.new
    if session.key?("current_store_id")
      redirect_to "/user/billing"
      # redirect_to "/add_inventory/new"

    end
  end

  def show

  end

  def create
    # @user = User.new(user_params)
    @user = User.new(firstName: params[:user][:firstName], lastName: params[:user][:lastName],
                     password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], email: params[:user][:email])
    @store = Store.new(shopName: params[:store][:shopName], registrationNumber: params[:store][:registrationNumber],
                       locality: params[:store][:locality], city: params[:store][:city], pin: params[:store][:pin])

    # @user.save
    # @store.save
    if @user.save and @store.save
      # @store.save
      @user.store = @store
      redirect_to "/users/new"
      # redirect_to "users/signin"
    else
      # redirect_to new_user_path(tab: :signup)
      # redirect_to "#{new_user_path}#signup"
      # (tab: :sign_up)
      render 'new'
    end
    # render json: @store
  end

  def signin
    # @user = params[:user]


    @email = params[:user][:email]
    @password = params[:user][:password]

    @user = User.where(email: @email, password: @password).first
    if @user
      @store = Store.where(user_id: @user.id).first
      session[:current_store_id] = @store.id
      # redirect_to "/dashboard/storedetails"
      redirect_to "/user/billing"
      # render 'logout'
      # render json: @user
    else
      render 'invalidlogin'
    end
  end

  def logout
    session.delete(:current_store_id);


    redirect_to "/users/new"
  end
end
