class Product < ApplicationRecord
	has_many :orders, :dependent => :destroy
	has_many :discounts, :dependent => :destroy

	validates :name, presence: true, length: { maximum: 20, minimum: 3 }
	validates :price, presence: true
	validates :quantity, presence: true
	validates :category, presence: true, length: { maximum: 20, minimum: 3 }
	def self.new_from_lookup(name)
        looked_up_product = Product.where("name LIKE ?", "%" + name + "%")
    end

end