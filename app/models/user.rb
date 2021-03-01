class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
         validates :nickname
         validates :password, :password_confirmation,         format: {with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/}
         validates :family_name,      format: {with: /\A[ぁ-んァ-ン一-龥々]+\z/}
         validates :given_name,       format: {with: /\A[ぁ-んァ-ン一-龥々]+\z/}
         validates :family_name_kana, format: {with: /\A[ァ-ヶー－]+\z/}
         validates :given_name_kana,  format: {with: /\A[ァ-ヶー－]+\z/}
         validates :birthday
  end



end
