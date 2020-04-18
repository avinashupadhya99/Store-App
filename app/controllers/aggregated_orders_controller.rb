class AggregatedOrdersController < ApplicationController

	before_action :require_user

	def index
		@agg_orders = AggregatedOrder.paginate(page: params[:page], per_page: 8)
	end

	def new

	end

	def create

	end

	def show
		@agg_order = AggregatedOrder.find(params[:id])
		@sub_orders = Order.where(aggregated_order: @agg_order)
	end

end