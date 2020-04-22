class AggregatedOrdersController < ApplicationController

	before_action :require_user

	def index
		@agg_orders = AggregatedOrder.paginate(page: params[:page], per_page: 8) #All aggregated orders
	end

	def new
		@agg_order = AggregatedOrder.new 
		 #Nested form for sub orders
	end

	def create
		@agg_order = AggregatedOrder.new(agg_order_params)
		if @agg_order.save
			flash[:success] = "Order was placed successfully"
			redirect_to aggregated_order_path(@agg_order)
		else
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