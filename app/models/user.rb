class User < ApplicationRecord
	has_one: employee, :dependent => :destroy
end