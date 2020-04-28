class User < ApplicationRecord
	attr_accessor :email #Used as a virtual attribute, only for sending the email to the controller from the view
	belongs_to :employee
	validates :password, length: {minimum: 5}, :if => :password
	has_secure_password
end