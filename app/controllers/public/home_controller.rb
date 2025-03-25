class Public::HomeController < ApplicationController
  def top
    #作成日時（created_at）を基準に降順（:desc）で並び替える
    @items = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end
