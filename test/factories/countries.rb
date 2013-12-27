FactoryGirl.define do
  factory :country do
    sequence(:name) { |n| "CountryName#{n}" }
    sequence(:code) { |n| "CountryCode#{n}" }
  end
end
