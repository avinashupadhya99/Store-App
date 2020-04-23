class ProductsController < ApplicationController

  before_action :require_user
  
  def index

  end
  
  def new
  	
  end

  def create
  end

  def edit
  end

  def update
  end

  def search
    if params[:product].blank?

    else
      @product = Product.new_from_lookup(params[:product])
      flash.now[:danger] = "No product with that name exists" unless @product.present?
    end
    respond_to do |format|
      format.js { render partial: 'aggregated_orders/product' }
    end
  end

end
