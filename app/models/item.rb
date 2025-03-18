class Item < ApplicationRecord
  belongs_to :genre_id
  has_many :cart_items
  has_many :order_details

  #attachment :image 
  has_one_attached :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}
end