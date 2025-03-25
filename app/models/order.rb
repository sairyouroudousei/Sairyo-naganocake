class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details


  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {awaiting_payment: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3 ,already_shipped: 4}

  def add_tax_price
    (self.item.price * 1.10).round
  end

  def total_amount
    order_details.sum { |order_detail| order_detail.price * order_detail.amount }
  end

  def shipping_address_for_view
    "#{postal_code}\n #{address}\n #{name}"
  end
end
