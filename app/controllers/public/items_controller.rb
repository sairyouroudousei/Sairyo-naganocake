class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8) # ← 1ページに8件ずつ表示
  end

  def show
    @item = Item.find(params[:id])
  end
end
