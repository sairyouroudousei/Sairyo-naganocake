class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(5) # ← 1ページに5件ずつ表示
  end

  def show
    @item = Item.find(params[:id])
  end
end
