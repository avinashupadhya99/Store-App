class DiscountsController < ApplicationController

	before_action :require_user

	def index
		if(params.has_key?(:type))
			type = params[:type]
			if type=="active"
				@discounts = Discount.where("starts_at <= ? AND ends_at >= ?", Date.today, Date.today).order(ends_at: :desc).paginate(page: params[:page], per_page: 6)
			elsif type=="expired"
				@discounts = Discount.where("starts_at < ? AND ends_at < ?", Date.today, Date.today).order(ends_at: :desc).paginate(page: params[:page], per_page: 6)
			elsif type=="notstarted"
				@discounts = Discount.where("starts_at > ? AND ends_at > ?", Date.today, Date.today).order(ends_at: :desc).paginate(page: params[:page], per_page: 6)
			else
				@discounts = Discount.order(ends_at: :desc, starts_at: :asc).paginate(page: params[:page], per_page: 6)
			end
		else
			@discounts = Discount.order(ends_at: :desc, starts_at: :asc).paginate(page: params[:page], per_page: 6)
		end
	end

	def new
	end

	def create

	end

	def edit
		#Check if a discount exists in the period mentioned for that product
	end

	def update

	end

	def destroy
	end

end