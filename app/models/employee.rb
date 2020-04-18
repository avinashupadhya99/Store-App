class Employee < ApplicationRecord
	has_many :aggregated_orders, :dependent => :destroy
	has_one :user, :dependent => :destroy
	before_save { self.email = email.downcase }
	validates :fName, presence: true, length: { maximum: 20, minimum: 3 }
	validates :lName, presence: true, length: { maximum: 20, minimum: 3 }
	validates :address, presence: true, length: { maximum: 100, minimum: 5 }
	validates :dob, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 105 },	uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	VALID_PHONE_REGEX = /\d/
	validates :phone, presence: true, length: { maximum: 10, minimum: 10}, uniqueness: true, format: { with: VALID_PHONE_REGEX }
end