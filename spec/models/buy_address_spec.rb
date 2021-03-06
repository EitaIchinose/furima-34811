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
      it "郵便番号、都道府県、市区町村、番地、電話番号、tokenの情報が存在すれば購入できる" do
        expect(@buy_address).to be_valid
      end

      it "建物名が空の場合でも購入できる" do
        @buy_address.building = nil
        expect(@buy_address).to be_valid
      end
    end

    context '購入が出来ない場合' do
      it "郵便番号にハイフンがついていない場合、購入できない" do
        @buy_address.postal_code = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it "郵便番号が空の場合、購入できない" do
        @buy_address.postal_code = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end

      it "郵便番号が全角の場合、購入できない" do
        @buy_address.postal_code = '１２３-４５６７'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end


      it "都道府県が1の場合、購入できない" do
        @buy_address.prefectures_id = 1
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Prefectures Select")
      end

      it "都道府県が空の場合、購入できない" do
        @buy_address.prefectures_id = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Prefectures Select")
      end

      it "市区町村が空の場合、購入できない" do
        @buy_address.municipality = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it "番地が空の場合、購入できない" do
        @buy_address.house_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("House number can't be blank")
      end

      it "電話番号が空の場合、購入できない" do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it "電話番号が12桁以上の場合、購入できない" do
        @buy_address.phone_number = 123456789123
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number is invalid")
      end

      it "電話番号が全角の場合、購入できない" do
        @buy_address.phone_number = '１２３'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number is invalid")
      end

      it "tokenが空の場合、購入できない" do
        @buy_address.token = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
