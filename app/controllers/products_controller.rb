class ProductsController < ApplicationController
  def index
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

  private

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :category_id, :status_id, :shipping_days_id, :shipping_area_id, :shipping_cost_id, :image).merge(user_id: current_user.id)
  end
end
