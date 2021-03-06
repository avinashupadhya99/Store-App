class CustomersController < ApplicationController
  
  before_action :require_user
  before_action :require_admin, except: [:search, :create]

  def index
  	@customers = Customer.paginate(page: params[:page], per_page: 4)
  end


  def new
  	
  end

  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        flash.now[:success] = "Customer created successfully"
        format.js { render partial: 'aggregated_orders/customer' }
      else
        format.js { render partial: 'aggregated_orders/customer' }
      end
    end
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
    if params[:customer].blank?
      
    else
      @customer = Customer.new_from_lookup(params[:customer])
      flash.now[:danger] = "No customer with that phone number exists" unless @customer
    end
    respond_to do |format|
      format.js { render partial: 'aggregated_orders/customer' }
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:fname, :lname, :phone, :email)
  end

end
