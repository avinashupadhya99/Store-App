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
		if @discount.valid?
			old_discount = Discount.where("starts_at <= ? AND ends_at >= ? AND product_id = ?", Date.parse(params[:discount][:starts_at]), Date.parse(params[:discount][:starts_at]), params[:discount][:product_id].to_i)
			old_discount1 = Discount.where("starts_at <= ? AND ends_at >= ? AND product_id = ?", Date.parse(params[:discount][:ends_at]), Date.parse(params[:discount][:ends_at]), params[:discount][:product_id].to_i)
			old_discount2 = Discount.where("starts_at >= ? AND ends_at <= ? AND product_id = ?", Date.parse(params[:discount][:starts_at]), Date.parse(params[:discount][:ends_at]), params[:discount][:product_id].to_i)
			if old_discount.present? || old_discount1.present? || old_discount2.present?
				flash.now[:danger] = "Discount already exists for the product in that period"
				render 'new'
			else	
				if @discount.save
					flash[:success] = "Discount created successfully"
					redirect_to discounts_path
				else
					render 'new'
				end
			end
		else
			render 'new'
		end
	end

	def edit
		@discount = Discount.find(params[:id])

	end

	def update
		@discount = Discount.find(params[:id])
		if @discount.valid?
			#Check if a discount exists in the period mentioned for that product
			old_discount = Discount.find_by("starts_at <= ? AND ends_at >= ? AND product_id = ?", Date.parse(params[:discount][:starts_at]), Date.parse(params[:discount][:starts_at]), params[:discount][:product_id].to_i)
			old_discount1 = Discount.find_by("starts_at <= ? AND ends_at >= ? AND product_id = ?", Date.parse(params[:discount][:ends_at]), Date.parse(params[:discount][:ends_at]), params[:discount][:product_id].to_i)
			old_discount2 = Discount.find_by("starts_at >= ? AND ends_at <= ? AND product_id = ?", Date.parse(params[:discount][:starts_at]), Date.parse(params[:discount][:ends_at]), params[:discount][:product_id].to_i)
			if (old_discount.present? && old_discount.id!=@discount.id) || (old_discount1.present? && old_discount1.id!=@discount.id) || (old_discount2.present? && old_discount2.id!=@discount.id)
				flash.now[:danger] = "Discount already exists for the product in that period"
				render 'new'
			else	
				if @discount.update(discount_params)
					flash[:success] = "Discount updated successfully"
					redirect_to discounts_path
				else
					render 'new'
				end
			end
		else
			render 'new'
		end
	end

	def destroy
	end

	private
	def discount_params
		params.require(:discount).permit(:starts_at, :ends_at, :percent, :product_id)
		
	end

end