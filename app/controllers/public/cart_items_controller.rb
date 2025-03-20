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
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    #アイテムを検索
    @item = Item.find(params[:item][:item_id])
    amount = params[:item][:amount].to_i

    #すでに存在する場合は数量を追加、存在しない場合は新しく作成
    @cart_item = current_customer.cart_items.find_or_initialize_by(item_id: @item.id)
    @cart_item.amount = (@cart_item.amount || 0) + amount

    if @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to @item
    end
  end

  
  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end
