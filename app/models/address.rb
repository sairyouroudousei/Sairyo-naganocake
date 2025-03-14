class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, length: {is: 7}, presence: true
  validates :address, presence: true
  validates :name, presence: true

  def shipping_address_for_view
    "#{postal_code} #{address} #{name}"
  end
end
