class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: { message: "名を入力してください" }
end
