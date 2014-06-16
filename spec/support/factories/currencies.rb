FactoryGirl.define do
  factory :currency do
    sequence(:name) { |n| "CurrencyName#{n}" }
    sequence(:code) { |n| "CurrencyCode#{n}" }
  end
end
