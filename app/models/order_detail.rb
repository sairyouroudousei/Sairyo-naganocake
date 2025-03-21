class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {unavoidable: 0, awaiting_manufacture: 1, in_production: 2, completion_of_production: 3,}
end
