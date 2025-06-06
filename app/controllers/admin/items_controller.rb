class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(8) 
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: '商品を登録しました。'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: '商品情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path, notice: '商品を削除しました。'
  end

  private
  def item_params
    params.require(:item).permit(:name, :genre_id, :introduction, :price, :is_active, :image)
  end
end
