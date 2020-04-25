class Order < ApplicationRecord
	belongs_to :aggregated_order
	belongs_to :product
	validates :amount, presence: true
end