class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_days
  belongs_to :shipping_area
  belongs_to :shipping_cost
  belongs_to :user
  has_one :buy
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :product_name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :price, format: { with: /\A[0-9]+\z/i, message: 'Half-width number' },
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category_id
      validates :status_id
      validates :shipping_days_id
      validates :shipping_area_id
      validates :shipping_cost_id
    end
  end
end
