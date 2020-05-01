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
		@discount = Discount.new
	end

	def create
		@discount = Discount.new(discount_params)
		if @discount.save
			flash[:success] = "Discount created successfully"
			redirect_to discounts_path
		else
			render 'new'
		end
	end

	def edit
		@discount = Discount.find(params[:id])
		#Check if a discount exists in the period mentioned for that product
	end

	def update

	end

	def destroy
	end

	private
	def discount_params
		params.require(:discount).permit(:starts_at, :ends_at, :percent, :product_id)
		
	end

end