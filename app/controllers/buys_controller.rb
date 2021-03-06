class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_product, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
      pay_product
      @buy_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_address).permit(:postal_code, :municipality, :house_number, :phone_number, :building, :prefectures_id).merge(
      user_id: current_user.id, product_id: params[:product_id], token: params[:token]
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def move_to_index
    redirect_to products_path unless @product.buy.blank? && @product.user_id != current_user.id
  end

  def pay_product
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: buy_params[:token],
      currency: 'jpy'
    )
  end
end
