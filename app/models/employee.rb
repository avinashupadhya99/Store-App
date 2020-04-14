class Employee < ApplicationRecord
	has_many :orders, :dependent => :destroy
	has_one :user, :dependent => :destroy
end