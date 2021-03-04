class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @products = Product.all.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to product_path
    else
      @product = product
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :category_id, :status_id, :shipping_days_id,
                                    :shipping_area_id, :shipping_cost_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    product = Product.find(params[:id])
    redirect_to action: :index unless product.user_id == current_user.id
  end
end
