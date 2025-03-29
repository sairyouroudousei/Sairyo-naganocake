class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    
    # 製作中になったら、注文のステータスを「製作中」に更新
    if @order_detail.in_production?
      @order_detail.order.in_production!
    # すべての注文詳細が「製作完了」なら、注文のステータスを「発送準備中」に更新
    elsif @order_detail.order.order_details.all?(&:completion_of_production?)
      @order_detail.order.preparing_to_ship!
    end

    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end