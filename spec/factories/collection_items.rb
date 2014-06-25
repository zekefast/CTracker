# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection_item do
    user
    currency
  end
end
