class AggregatedOrdersController < ApplicationController

	before_action :require_user

	def index
		@agg_orders = AggregatedOrder.paginate(page: params[:page], per_page: 10) #All aggregated orders
	end

	def new
		@agg_order = AggregatedOrder.new 
		@customer_new = Customer.new #For new customer form
	end

	def create
		@agg_order = AggregatedOrder.new(agg_order_params)
		if @agg_order.save
			sub_orders = Order.where(aggregated_order: @agg_order)
			if sub_orders.length()==0
				@agg_order.destroy
				flash.now[:danger] = "Order should contain a minimum of one item"
				@customer_new = Customer.new #For new customer form
				render 'new'
			else
				flash[:success] = "Order was placed successfully #{sub_orders.length()}"
				redirect_to aggregated_order_path(@agg_order)
			end
		else
			@customer_new = Customer.new #For new customer form
			render 'new'
		end
	end

	def show
		@agg_order = AggregatedOrder.find(params[:id])
		@sub_orders = Order.where(aggregated_order: @agg_order) #All orders of the aggregated order
	end


	private

	def agg_order_params
		params.require(:aggregated_order).permit(:employee_id, :customer_id, orders_attributes: [:id, :product_id, :quantity, :amount, :_destroy])
	end
end