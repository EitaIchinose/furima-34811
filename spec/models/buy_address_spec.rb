require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  describe '商品の購入' do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @buy_address = FactoryBot.build(:buy_address, user_id: user.id, product_id: product.id)
      sleep(1)
    end

    context '商品の購入が出来る場合' do
      it '郵便番号、都道府県、市区町村、番地、電話番号、tokenの情報が存在すれば購入できる' do
        expect(@buy_address).to be_valid
      end

      it '建物名が空の場合でも購入できる' do
        @buy_address.building = nil
        expect(@buy_address).to be_valid
      end
    end

    context '購入が出来ない場合' do
      it '郵便番号にハイフンがついていない場合、購入できない' do
        @buy_address.postal_code = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('郵便番号にハイフン(-)を入れてください')
      end

      it '郵便番号が空の場合、購入できない' do
        @buy_address.postal_code = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('郵便番号を入力してください', '郵便番号にハイフン(-)を入れてください')
      end

      it '郵便番号が全角の場合、購入できない' do
        @buy_address.postal_code = '１２３-４５６７'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('郵便番号にハイフン(-)を入れてください')
      end

      it '都道府県が1の場合、購入できない' do
        @buy_address.prefectures_id = 1
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('都道府県を選択してください')
      end

      it '都道府県が空の場合、購入できない' do
        @buy_address.prefectures_id = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('都道府県を選択してください')
      end

      it '市区町村が空の場合、購入できない' do
        @buy_address.municipality = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('市区町村を入力してください')
      end

      it '番地が空の場合、購入できない' do
        @buy_address.house_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('番地を入力してください')
      end

      it '電話番号が空の場合、購入できない' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('電話番号を入力してください')
      end

      it '電話番号が12桁以上の場合、購入できない' do
        @buy_address.phone_number = '123456789123'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が全角の場合、購入できない' do
        @buy_address.phone_number = '１２３'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が英数混合の場合、購入できない' do
        @buy_address.phone_number = '123456789abc'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'tokenが空の場合、購入できない' do
        @buy_address.token = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('クレジットカード情報を入力してください')
      end

      it 'user_idが空の場合、購入できない' do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Userを入力してください')
      end

      it 'product_idが空の場合、購入できない' do
        @buy_address.product_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Productを入力してください')
      end
    end
  end
end
