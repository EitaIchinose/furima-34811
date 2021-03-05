class BuyAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postal_code, :municipality, :house_number, :phone_number, :building, :prefecutures_id

  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9]{,11}\z/}
    validates :prefecutures_id, numericality: {other_than: 1, message: "can't be blank"}
  end

  def save
    buy = Buy.create(user_id: user_id, product_id: product_id)
    address.create(postal_code: postal_code, municipality: municipality, house_number: house_number, phone_number: phone_number, building: building, prefecutures_id: prefecutures_id, buy_id: buy.id )
  end
end