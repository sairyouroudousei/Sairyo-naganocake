class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum payment_method: {credit_card: 0, transfer: 1}
  enum order_status: {awaiting_payment: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3 ,already_shipped: 4}

  def add_tax_price
    (self.item.price * 1.10).round
  end

    #小計
    def subtotal(cart_item)
      item.tax_included_price * amount
    end
end
