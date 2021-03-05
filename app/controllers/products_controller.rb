class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]


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
    @buy = Buy.new
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :category_id, :status_id, :shipping_days_id,
                                    :shipping_area_id, :shipping_cost_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless @product.user_id == current_user.id && @product.buy.blank?
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
