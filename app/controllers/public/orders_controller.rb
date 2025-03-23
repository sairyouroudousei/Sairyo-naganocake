class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  #注文情報入力(支払方法・配送先の選択)
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all 
  end

  #注文情報確認
  def confirm #途中 0,1のif文
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
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
  #支払い情報の値だけ取得する
  def order_params
    params.require(:order).permit(:payment_method)
  end
end
