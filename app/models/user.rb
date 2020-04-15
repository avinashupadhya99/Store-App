class User < ApplicationRecord
	attr_accessor :email #Used as a virtual attribute, only for sending the email to the controller from the view
	has_one :employee, :dependent => :destroy
	validates :password, length: {minimum: 4}, :if => :password
	has_secure_password
end