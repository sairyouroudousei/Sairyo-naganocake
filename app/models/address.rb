class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, length: {is: 7}, presence: true
  validates :address, presence: true
  validates :name, presence: true

  #配送先表示させるためのメソッド
  def shipping_address_for_view
    "#{postal_code} #{address} #{name}"
  end

  #既存の配送先を表示させるためのメソッド
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
