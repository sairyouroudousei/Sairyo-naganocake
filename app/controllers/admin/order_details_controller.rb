class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    
    # 製作中になったら、注文のステータスを「製作中」に更新
    if 
      @order_detail.making_status == "製作中"
      @order_detail.order.update(status: "製作中")
    end

    # すべての注文詳細が「製作完了」なら、注文のステータスを「発送準備中」に更新
    if 
      @order_detail.making_status == "製作完了" && 
      @order_detail.order.order_details.all? { |detail| detail.making_status == "製作完了" }
      @order_detail.order.update(status: "発送準備中")
    end

    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end