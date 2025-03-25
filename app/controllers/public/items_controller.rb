class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(2) # ← 1ページに2件ずつ表示
  end

  def show
    @item = Item.find(params[:id])
  end
end
