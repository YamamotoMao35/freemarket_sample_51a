class Shipment < ApplicationRecord
  belongs_to_active_hash :prefecture
  belongs_to :item
end
