class CustomersController < ApplicationController
  
  before_action :require_user
  before_action :require_admin

  def index
  	@customers = Customer.paginate(page: params[:page], per_page: 4)
  end


  def new
  	
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  	@customer = Customer.find(params[:id])
    all_orders = AggregatedOrder.where(customer_id: @customer.id)
    @all_orders_page = all_orders.paginate(page: params[:page], per_page: 4)
    @sub_orders = Order.where(aggregated_order_id: all_orders).distinct.pluck(:product_id)
  	@items_bought = @sub_orders.count

  end

end
