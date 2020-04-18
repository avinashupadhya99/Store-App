class Customer < ApplicationRecord
	has_many :aggregated_orders, :dependent => :destroy
	before_save { self.email = email.downcase }
	validates :fname, presence: true, length: { maximum: 20, minimum: 3 }
	validates :lname, presence: true, length: { maximum: 20, minimum: 3 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 105 },	uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	VALID_PHONE_REGEX = /\d/
	validates :phone, presence: true, length: { maximum: 10, minimum: 10}, uniqueness: true, format: { with: VALID_PHONE_REGEX }
end