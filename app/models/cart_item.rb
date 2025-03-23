class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  #税込価格
  def tax_included_price
    (item.price * 1.1).floor
  end

  #小計
  def subtotal(cart_item)
    item.tax_included_price * amount
  end
end
