class Customer < ApplicationRecord
	has_many :orders, :dependent => :destroy

end