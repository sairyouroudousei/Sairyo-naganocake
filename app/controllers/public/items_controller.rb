class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8) # ← 1ページに8件ずつ表示
  end

  def show
    @item = Item.find(params[:id])
  end
end
