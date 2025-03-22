class Public::CartItemsController < ApplicationController
  #before_action :authenticate_customer!
  def index
    @cart_items = CartItem.all
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

  def create 
        #検索と数字型に変換
        @item = Item.find(params[:cart_item][:item_id])
        amount = params[:cart_item][:amount].to_i
    
        #追加した商品がカート内に存在するかの判別
        #カート内の個数をフォームから送られた個数分追加する
        @cart_item = current_customer.cart_items.find_or_initialize_by(item_id: @item.id)
        @cart_item.amount = (@cart_item.amount || 0) + amount
    
        if @cart_item.save
          redirect_to cart_items_path
        else
          redirect_to my_page_path
        end
      end


  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
