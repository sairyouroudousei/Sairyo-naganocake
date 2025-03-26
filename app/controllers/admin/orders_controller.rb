class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  # GET /admin/orders/:id
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  # PATCH /admin/orders/:id
  def update
    @order = Order.find(params[:id])
  
    if @order.update(order_params)
      @order_details = @order.order_details
  
      # 製作ステータスが更新された後に注文ステータスを変更
      if @order.payment_confirmation?
        @order_details.each { |detail| detail.awaiting_manufacture! }
      elsif @order.already_shipped?
        @order_details.each { |detail| detail.already_shipped! }
      end
      
      if @order.save
        flash[:notice] = "注文の更新に成功しました。"
        redirect_to admin_order_path(@order)
      else
        flash[:alert] = "注文ステータスの更新に失敗しました。"
        redirect_back(fallback_location: admin_order_path(@order))
      end
    else
      flash[:alert] = "注文の更新に失敗しました。"
      redirect_back(fallback_location: admin_order_path(@order))
    end
  end
  

  private

  def order_params
    params.require(:order).permit(:status)
  end

  
end