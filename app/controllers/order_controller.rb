require 'will_paginate/array'

class OrderController < ApplicationController
  def index
    unless session.key? :current_store_id
      redirect_to "/users/new"
      return
    end
    @store = Store.find(session[:current_store_id])
    @user = @store.user
    @orders = Order.all.find_all {|order| order.user_id == @user.id}
    @orders = filter_orders(@orders, params[:search])
    @orders = @orders.paginate(:per_page => 10, :page => params[:page])
  end

  def filter_orders(orders, query)
    if query.nil? or query.strip.empty?
      return orders
    end
    query = query.downcase
    orders.find_all{|order| order.customer != nil and (order.customer.name.downcase.include?query or order.customer.phone_number.include?query or order.id == query)}
  end
end
