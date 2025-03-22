class Public::CartItemsController < ApplicationController
  #before_action :authenticate_customer!
  def index 
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    #1こだけ削除
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    #全削除
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create #途中
    #商品IDと個数を探す
    @item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    amount = params[:cart_item][:amount].to_i

    #presentで値が入っているかを確認
    if @item.present?
      cart_item_amount = item.amount + params[:cart_item][:amount].to_i
      item.save
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      #cart_item.customer_id = current_customer.id
      @cart_item.amount = (@cart_item.amount || 0) + amount
      @cart_item.save
      redirect_to my_page_path
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
