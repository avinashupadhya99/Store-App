class Product < ApplicationRecord
	has_many :orders, :dependent => :destroy

	def self.new_from_lookup(name)
        looked_up_product = Product.where("name LIKE ?", "%" + name + "%")
    end

end