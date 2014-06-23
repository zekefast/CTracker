# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    sequence(:name) { |n| "CountryName#{n}" }
    sequence(:code) { |n| "CountryCode#{n}" }
  end
end
