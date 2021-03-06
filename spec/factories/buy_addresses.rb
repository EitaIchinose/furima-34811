FactoryBot.define do
  factory :buy_address do
    postal_code { '123-4567'}
    municipality { '千葉市' }
    house_number { '1-1' }
    phone_number { '12345678912'}
    prefectures_id { 2 }
    token { "tok_abcdefghijk00000000000000000" }
  end
end
