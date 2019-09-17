require 'will_paginate/array'
class AddInventoryController < ApplicationController

  def new
    if session.key? :current_store_id
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)
      @categories = Category.all.find_all {|category| category.user_id == 1} #all categories displayed to user in dropdown
    else
      redirect_to "/users/new"
    end
  end

  def create
    if session.key? :current_store_id
      @changesMade = "null"
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)
      @add_catalogue_item = CatalogItem.new(name: params[:catalog_item][:name], qty: params[:catalog_item][:qty], price: params[:catalog_item][:price], category_id: params[:catalog_item][:category_id])
      begin
        if @add_catalogue_item.save
          @add_catalogue_item.user_id=@user.id
          @add_catalogue_item.save
        end
        @changesMade = "true"
      rescue
        @changesMade = "false"
      end

      redirect_to "/dashboard/inventory?changes_made="+@changesMade

    else
      redirect_to "/users/new"
    end
  end

  def inventory
    if session.key? :current_store_id
      @changesMade = "null"
      if params[:changes_made]
        @changesMade = params[:changes_made]
      end
      @store = Store.find(session[:current_store_id])
      @user = User.find(@store.user_id)

      @categories = Category.all.find_all {|category| category.user_id == 1} #all categories displayed to user in dropdown
      @filtered_catalog_items = CatalogItem.all.find_all {|item| item.user_id == @user.id and item.qty >= 0} #all the items to be displayed

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

      @filtered_catalog_items = @filtered_catalog_items.paginate(:per_page => 10, :page => params[:page])

    else
      redirect_to "/users/new"
    end

  end

end
