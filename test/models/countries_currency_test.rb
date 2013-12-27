require "test_helper"


class CountriesCurrencyTest < ActiveSupport::TestCase
  should belong_to(:country)
  should belong_to(:currency)
  should have_many(:collections)
  should have_many(:users).through(:collections)

  should validate_presence_of(:country)
  should validate_presence_of(:currency)
end
