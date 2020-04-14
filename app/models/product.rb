class Product < ApplicationRecord
	has_many :orders, :dependent => :destroy

end