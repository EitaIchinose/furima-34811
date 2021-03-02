FactoryBot.define do
  factory :product do
    product_name {Faker::Name.name}
    description {Faker::Lorem.sentences}
    price { 1000 }
    category_id { 2 }
    status_id { 2 }
    shipping_days_id { 2 }
    shipping_area_id { 2 }
    shipping_cost_id { 2 }
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
