require 'will_paginate/array'
require 'json'
class CatalogItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def addToCart
    if session.key? :current_store_id
      @new_items = []
      @cart_items = []
      if session[:cart_items]
        session[:cart_items].each do |item_id|
          @cart_items << CatalogItem.find {|item| item.id == item_id}
        end
      end

      if params[:selected_items]
        params[:selected_items].each do |item_id|
          item = CatalogItem.all.find {|item| item.id.to_s == item_id}
          #p 'adding item'
          #p item
          @cart_items << item
          @new_items << item
        end
        session[:cart_items] = @cart_items.collect {|item| item.id}
      end
      p "Returned items: #{@new_items}"
      p "Session items: #{session[:cart_items]}"
      render json: @new_items
    else
      redirect_to "/users/new"
    end
  end


  def removeFromCart

    if session.key? :current_store_id
      @removed_items = []

      @cart_items = []
      if session[:cart_items]
        session[:cart_items].each do |item_id|
          @cart_items << CatalogItem.find {|item| item.id == item_id}
        end
      end
      p "Existing cart items: #{@cart_items}"

      if params[:selected_items_cart]
        params[:selected_items_cart].each do |item_id|
          #session[:cart_items].delete item_id.to_i
          item = CatalogItem.all.find {|item| item.id.to_s == item_id}
          @removed_items << item
        end
        params[:selected_items_cart].each do |item_id|
          #session[:cart_items].delete item_id.to_i
          @cart_items.each_with_index do |item_it,ind|
            p "#{item_id} : #{item_it.id} + #{ind}"
            if item_id.chomp.to_i == item_it.id.to_i
              @cart_items.delete_at(ind)
              break
            end
          end
        end
        p "New cart items: #{@cart_items}"
        session[:cart_items] = @cart_items.collect {|item| item.id}
      end
      p "Returned items: #{@removed_items}"
      p "Session items: #{session[:cart_items]}"
      render json: @removed_items
    else
      redirect_to "/users/new"
    end

  end


  def billing
    if session.key? :current_store_id
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)
      p 'params' + params.to_s
      #restore cart items from session
      @cart_items = []
      if session[:cart_items]
        session[:cart_items].each do |item_id|
          @cart_items << CatalogItem.find {|item| item.id == item_id}
        end
        p 'session cart items'
        p session[:cart_items]
        p 'cart_items'
        p @cart_items
      end

      #Adding item to cart & removing items from cart
      if params[:commit]
        if params[:commit] == 'Add'
          if params[:selected_items]
            params[:selected_items].each do |item_id|
              item = CatalogItem.all.find {|item| item.id.to_s == item_id}
              p 'adding item'
              p item
              @cart_items << item
            end
            session[:cart_items] = @cart_items.collect {|item| item.id}
          else
            #show error dialog!
          end
        elsif params[:commit] == 'Remove'
          if params[:selected_items_cart]
            params[:selected_items_cart].each do |item_id|
              session[:cart_items].delete item_id.to_i
              p 'deleting' + item_id.to_s
            end
            reset_cart_items
          else
            #error dialog
          end
        end
      end

      #todo rewrite the following two lines to use session variables not on the category
      @categories = Category.all.find_all {|category| category.user_id == 1} #all categories displayed to user in dropdown

      #@filtered_catalog_items = CatalogItem.all.find_all {|item| item.user_id == 1 and item.qty > 0} #all the items to be displayed
      @filtered_catalog_items = CatalogItem.all.find_all {|item| item.user_id == @user.id and item.qty > 0}

      if params[:search] and params[:search][:category_id] and params[:search][:category_id] != ''
        @cat_search = params[:search][:category_id]
        @filtered_catalog_items = @filtered_catalog_items.find_all {|item| item.category.id.to_s == params[:search][:category_id]}
        p 'after filtering category' + @filtered_catalog_items.to_s
      end

      if params[:search_term]
        @text_search = params[:search_term]
        @filtered_catalog_items = @filtered_catalog_items.find_all {|item| item.name.downcase.include?(params[:search_term].downcase)}
        p 'after filtering term' + @filtered_catalog_items.to_s
      end

      @filtered_catalog_items = @filtered_catalog_items.paginate(:per_page => 5, :page => params[:page])


    else
      redirect_to "/users/new"
    end

  end

  def reset_cart_items #def changed
    if session.key? :current_store_id
      session[:cart_items] = []
      @cart_items = []
      #session[:cart_items].each do |item_id|
        #@cart_items << CatalogItem.find {|item| item.id == item_id}
      #end
    else
      redirect_to "/users/new"
    end
  end

  def clearCart
    if session.key? :current_store_id
      @cleared_cart = []
      session[:cart_items] = @cleared_cart
      p "Session items: #{session[:cart_items]}"
      render json: @cleared_cart
    else
      redirect_to "/users/new"
    end
  end

  def validate_cart
    if session.key? :current_store_id
      problem_items = []
      params['cart_ids'].each_with_index  do |item_id, ind|
        curr_cat_item = CatalogItem.find {|item| item.id.to_s == item_id}
        if curr_cat_item.qty < params['cart_quants'][ind].chomp.to_i
          problem_items << curr_cat_item.name
          p problem_items
        end
      end
      render json: problem_items
    else
      redirect_to "/users/new"
    end

  end

  def checkout
    if session.key? :current_store_id
      p params
      @customer_name = params[:customer_name]
      @customer_phone_number = params[:customer_phone_number]

      @store = Store.find(session[:current_store_id])
      user = User.find(@store.user_id)
      begin
        @total = 0
        @checkout_items_map = Hash.new
        params['cart_ids'].each_with_index  do |item_id, ind|
          curr_cat_item = CatalogItem.find {|item| item.id.to_s == item_id}
          @checkout_items_map[curr_cat_item] = params['cart_quants'][ind].chomp.to_i
          @total = @total + curr_cat_item.price*params['cart_quants'][ind].chomp.to_i
        end


        @success = true
        customer = Customer.create name: @customer_name, phone_number: @customer_phone_number
        order = Order.create customer: customer, user: user
        @checkout_items_map.each do |item, quantity|
          item.qty -= quantity
          if item.qty < 0
            raise 'Not enough stock'
          end
          order_item = OrderItem.create catalog_item: item, quantity: quantity
          order_item.save
          order.order_items << order_item
        end
        customer.save
        order.total = @total
        order.date = Date.today
        order.save
        @checkout_items_map.each do |item, quantity|
          item.save
        end
        reset_cart_items #Changed its functionality
        @order_id  = order.id
      rescue => exception
        p exception.inspect
        @success = false
      end
    else
      redirect_to "/users/new"
    end

  end

  def update
    @changesMade = "null"
    @catalog_item = CatalogItem.find(params[:id])
    @catalog_item.name = params[:catalog_item][:name]
    @catalog_item.qty = params[:catalog_item][:qty]
    @catalog_item.category_id = params[:catalog_item][:category_id]
    @catalog_item.price = params[:catalog_item][:price]
    begin
      @catalog_item.save
      @changesMade = "true"
    rescue
      @changesMade = "false"
    end

    #@catalog_item = params[:catalog_item]
    #@catalog_item.save

    redirect_to "/dashboard/inventory?changes_made="+@changesMade
  end

  def destroy
    @changesMade = "null"
    @catalog_item = CatalogItem.find(params[:id])
    begin
      @catalog_item.destroy
      @changesMade = "true"
    rescue
      @changesMade = "false"
    end
    redirect_to "/dashboard/inventory?changes_made="+@changesMade
  end

  def edit
    if session.key? :current_store_id
      @catalog_item = CatalogItem.find(params[:id])
    end
  end
end
