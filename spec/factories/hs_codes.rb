FactoryBot.define do
  factory :hs_code do
    code { "MyString" }
    product_name { "MyString" }
    description { "MyText" }
    category { "MyString" }
    tariff_rate { "9.99" }
    unit { "MyString" }
    notes { "MyText" }
  end
end
