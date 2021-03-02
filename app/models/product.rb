class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_days
  belongs_to :shipping_area
  belongs_to :shipping_cost
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :product_name
    validates :description
    validates :price
    validates :user_id
    validates :image
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :shipping_days_id
      validates :shipping_area_id
      validates :shipping_cost_id
    end
  end
end
