class Discount < ApplicationRecord
	belongs_to :product
	validates :starts_at, presence: true
	validates :ends_at, presence: true
	validates :percent, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
	validate :start_date_cannot_be_in_the_past, on: :create
	validate :ends_date_cannot_be_in_the_past
 
	def start_date_cannot_be_in_the_past
		if starts_at.present? && starts_at < Date.today
			errors.add(:starts_at, "can't be in the past")
		end
	end

	def ends_date_cannot_be_in_the_past
		if ends_at.present? && ends_at < Date.today
			errors.add(:ends_at, "can't be in the past")
		end
	end

end