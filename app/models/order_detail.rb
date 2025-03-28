class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item, optional: true  # これを追加

  enum making_status: {unavoidable: 0, awaiting_manufacture: 1, in_production: 2, completion_of_production: 3, already_shipped: 4}

  def add_tax_price
    return 0 unless item  # item が nil の場合は 0 を返す
    (item.price * 1.10).round
  end
end
