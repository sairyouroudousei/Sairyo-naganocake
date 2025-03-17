class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
  end

  def confirm
  end

  def thanks
  end

  def create
  end

  def index
    @customer = current_customer
    @orders = @customer.orders.includes(:order_details).order(crested_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end
end
