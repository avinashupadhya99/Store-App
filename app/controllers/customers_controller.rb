class CustomersController < ApplicationController
  
  before_action :require_user
  before_action :require_admin, except: [:search]

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
    all_orders = AggregatedOrder.where(customer_id: @customer.id) #All aggregated orders of the customer
    @all_orders_page = all_orders.paginate(page: params[:page], per_page: 4) #Paginate the aggregated orders
  	@items_bought = Order.where(aggregated_order_id: all_orders).distinct.pluck(:product_id).count #Count of all sub orders of the customer with distinct products, i.e, the number of distinct products(items) bought by the customer

  end

  def search
    if params[:customer].present?
      @customer = Customer.new_from_lookup(params[:customer])
      if @customer
        respond_to do |format|
          format.js { render partial: 'aggregated_orders/customer' }
        end        
      else
        flash[:danger] = "No customer with that phone number"
        redirect_to new_aggregated_order_path
      end
    else
      redirect_to new_aggregated_order_path
    end
  end

end
