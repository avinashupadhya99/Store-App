class CustomersController < ApplicationController
  
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
  	@items_bought = Order.where(customer_id: @customer.id).sum(:quantity)

  end

end
