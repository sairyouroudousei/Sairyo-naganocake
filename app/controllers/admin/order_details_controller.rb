class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      case @order_detail.making_status
      when "製作中"
        @order_detail.order.update(status: "製作中")
      when "製作完了"
        if @order_detail.order.order_details.all? { |od| od.making_status == "製作完了" }
          @order_detail.order.update(status: "発送準備中")
        end
      end
      redirect_to admin_order_path(@order_detail.order)
    else
      flash[:alert] = "更新に失敗しました"
      redirect_back(fallback_location: admin_order_path(@order_detail.order))
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end