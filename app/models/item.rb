class Item < ApplicationRecord
  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  has_one_attached :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :is_active, inclusion: { in: [true, false] }
end