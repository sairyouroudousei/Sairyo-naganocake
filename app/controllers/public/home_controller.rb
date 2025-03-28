class Public::HomeController < ApplicationController
  def top
    #作成日時（created_at）を基準に降順（:desc）で並び替える
    @items = Item.where(is_active: true).order(created_at: :desc).limit(4)  # 販売中の最新の4つを取得
  end

  def about
  end
end
