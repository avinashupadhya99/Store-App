class ProductsController < ApplicationController

  before_action :require_user
  
  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
  end
  
  def new
  	@product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product is successfully stored"
      redirect_to products_path(@product)
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "Product information is updated"
      redirect_to products_path(@product)
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:danger] = "Product was successfully deleted"
    redirect_to product_path
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

  private 

  def product_params 
    params.require(:product).permit(:name, :price, :quantity, :category)
  end

end
