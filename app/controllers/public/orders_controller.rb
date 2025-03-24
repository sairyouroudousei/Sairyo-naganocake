class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  #注文情報入力(支払方法・配送先の選択)
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all 
  end

  #注文情報確認
  def confirm 
    @cart_items = current_customer.cart_items
    @shipping_cost = 800
    @total = @cart_items.sum { |cart_item| cart_item.tax_included_price * cart_item.amount }
    @order = Order.new

    @order.payment_method = params[:order][:payment_method]
    

    #選択した支払い方法が何かを判別する
    if params[:order][:address_type] == "member_address"
      #orders/newでご自身の住所を選択した場合
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_type] == "registered_address" 
      #orders/newで登録済住所を選択した場合
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_type] == "new_address" 
      #新しいお届け先を選択した場合
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  #注文確定処理
  def create
    @order = Order.new(order_params)
    @order.shipping_cost = 800 
  

    #items_priceの合計を出す何かかoder_idを引っ張ってくるか

  end

  def index
    @customer = current_customer
    @orders = @customer.orders.includes(:order_details).order(crested_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :address_type, :address_id)
  end
end
