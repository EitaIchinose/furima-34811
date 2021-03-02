require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品の出品/商品情報' do
    context '商品の出品ができる場合' do
      it '画像、商品名、説明、カテゴリー、商品の状態、販売価格が存在すれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '商品の出品ができない場合' do
      it '画像が空の場合、出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空の場合、出品できない' do
        @product.product_name = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Product name can't be blank")
      end

      it '商品の説明がからの場合、出品できない' do
        @product.description = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報が空の場合、出品できない' do
        @product.category_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank", "Category Select")
      end

      it '商品の状態についての情報が空の場合、出品できない' do
        @product.status_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Status can't be blank", "Status Select")
      end

      it '販売価格についての情報が空の場合、出品できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank", "Price Half-width number", "Price Out of setting range")
      end

      it '販売価格は、全角で記入されていた場合、出品できない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end

      it '販売価格が¥299以下の場合、出品できない' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end

      it '販売価格が¥10000000以上の場合、出品できない' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end
    end
  end

  describe '商品の出品/配送情報' do
    context '商品の出品ができる場合' do
      it '配送料の負担、発送元の地域、発送までの日数の情報が存在すれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '商品の出品ができない場合' do
      it '配送料の負担の情報が空の場合、出品できない' do
        @product.shipping_cost_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping cost can't be blank", "Shipping cost Select")
      end

      it '発送元の地域の情報が空の場合、出品できない' do
        @product.shipping_area_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping area can't be blank", "Shipping area Select")
      end

      it '発送までの日数の情報が空の場合、出品できない' do
        @product.shipping_days_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping days can't be blank", "Shipping days Select")
      end
    end
  end
end
