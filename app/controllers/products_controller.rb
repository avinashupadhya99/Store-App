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
      @product = Product.new_from_lookup(params[:product]).paginate(page: params[:page], per_page: 7)
      flash.now[:danger] = "No product with that name exists" unless @product.present?
    end
    respond_to do |format|
      format.js { render partial: 'aggregated_orders/product' }
    end
  end

end
