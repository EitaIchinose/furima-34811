require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録がうまくいくとき' do
      it 'nickname、email、password、password_confirmationが存在すれば登録が可能' do
        expect(@user).to be_valid
      end

      it 'パスワードは、6文字以上入力されていれば、登録が可能' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end

      it 'パスワードは、半角英数字が混合されていれば、登録が可能' do
        @user.password = 'aaa123'
        @user.password_confirmation = 'aaa123'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another = FactoryBot.build(:user)
        another.email = @user.email
        another.valid?
        expect(another.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'testexample'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                      'Password confirmation is invalid')
      end

      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc124'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードは、数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
      end

      it 'パスワードは、英語のみでは登録できない' do
        @user.password = 'abcefg'
        @user.password_confirmation = 'abcefg'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
      end

      it 'パスワードは、全角では登録できない' do
        @user.password = 'ＡＢＣ１２３'
        @user.password_confirmation = 'ＡＢＣ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
      end
    end
  end

  describe '新規登録/本人情報確認' do
    context '新規登録がうまくいくとき' do
      it 'family_name、given_name、family_name_kana、given_name_kana、birthdayが存在すれば登録が可能' do
        expect(@user).to be_valid
      end

      it 'ユーザー本名を、全角（漢字・ひらがな・カタカナ）で入力すれば登録が可能' do
        @user.family_name = '山田'
        @user.given_name = '太郎'
        expect(@user).to be_valid
      end

      it 'ユーザー本名のフリガナを、全角（カタカナ）で入力すれば登録が可能' do
        @user.family_name_kana = 'ヤマダ'
        @user.given_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'ユーザー本名の名字が、空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'ユーザー本名の名前が、空だと登録できない' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank")
      end

      it 'ユーザー本名の名字を、全角（漢字・ひらがな・カタカナ）以外で入力した場合、登録できない' do
        @user.family_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end

      it 'ユーザー本名の名前を、全角（漢字・ひらがな・カタカナ）以外で入力した場合、登録できない' do
        @user.given_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name is invalid')
      end

      it 'ユーザー本名の名字（フリガナ）が空だと登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it 'ユーザー本名の名前（フリガナ）が空だと登録できない' do
        @user.given_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana can't be blank")
      end

      it 'ユーザー本名の名字（フリガナ）を、全角（カタカナ）以外で入力した場合、登録できない' do
        @user.family_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana is invalid')
      end

      it 'ユーザー本名の名前（フリガナ）を、全角（カタカナ）以外で入力した場合、登録できない' do
        @user.given_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name kana is invalid')
      end

      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
