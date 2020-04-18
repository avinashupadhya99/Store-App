class Order < ApplicationRecord
	belongs_to :aggregated_order
	belongs_to :product
end