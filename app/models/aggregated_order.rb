class AggregatedOrder < ApplicationRecord
	belongs_to :customer
	belongs_to :employee
	has_many :orders, dependent: :destroy
	accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['quantity'].blank? }, allow_destroy: true
end