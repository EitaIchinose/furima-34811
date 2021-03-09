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
        expect(@product.errors.full_messages).to include('画像を選択してください')
      end

      it '商品名が空の場合、出品できない' do
        @product.product_name = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('商品名を入力してください')
      end

      it '商品の説明がからの場合、出品できない' do
        @product.description = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('商品の説明を入力してください')
      end

      it 'カテゴリーの情報が空の場合、出品できない' do
        @product.category_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('カテゴリーを入力してください', 'カテゴリーを選択してください')
      end

      it '商品の状態についての情報が空の場合、出品できない' do
        @product.status_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('商品の状態を入力してください', '商品の状態を選択してください')
      end

      it '販売価格についての情報が空の場合、出品できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('価格を入力してください', '価格は不正な値です', '価格は¥300〜9,999,999内の値で入力してください')
      end

      it '販売価格は、全角で記入されていた場合、出品できない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include('価格は¥300〜9,999,999内の値で入力してください')
      end

      it '販売価格が¥299以下の場合、出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('価格は¥300〜9,999,999内の値で入力してください')
      end

      it '販売価格が¥10000000以上の場合、出品できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('価格は¥300〜9,999,999内の値で入力してください')
      end

      it '販売価格は半角英数混合にて入力した場合、出品できない' do
        @product.price = '123abc'
        @product.valid?
        expect(@product.errors.full_messages).to include('価格は¥300〜9,999,999内の値で入力してください')
      end

      it '販売価格は半角英語にて入力した場合、出品できない' do
        @product.price = 'abcd'
        @product.valid?
        expect(@product.errors.full_messages).to include('価格は¥300〜9,999,999内の値で入力してください')
      end

      it '商品の状態が１の場合、出品できない' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('商品の状態を選択してください')
      end

      it 'カテゴリーが１の場合、出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('カテゴリーを選択してください')
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
        expect(@product.errors.full_messages).to include('配送料の負担を入力してください', '配送料の負担を選択してください')
      end

      it '発送元の地域の情報が空の場合、出品できない' do
        @product.shipping_area_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('発送元の地域を入力してください', '発送元の地域を選択してください')
      end

      it '発送までの日数の情報が空の場合、出品できない' do
        @product.shipping_days_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('発送までの日数を入力してください', '発送までの日数を選択してください')
      end

      it '発送料の負担が１の場合、出品できない' do
        @product.shipping_cost_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('配送料の負担を選択してください')
      end

      it '発送元の地域が１の場合、出品できない' do
        @product.shipping_area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('発送元の地域を選択してください')
      end

      it '発送までの日数が１の場合、出品できない' do
        @product.shipping_days_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('発送までの日数を選択してください')
      end
    end
  end
end
