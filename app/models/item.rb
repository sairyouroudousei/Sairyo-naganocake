class Item < ApplicationRecord
  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  has_one_attached :image
  validates :name, presence: { message: "を入力してください" }
  validates :introduction, presence: { message: "を入力してください" }
  validates :price,presence: { message: "を入力してください" },numericality: {only_integer: true,greater_than_or_equal_to: 0,message: "は0円以上の整数で入力してください"}
  validates :is_active, inclusion: { in: [true, false] }
  validates :genre_id, presence: { message: "を入力してください" }

end