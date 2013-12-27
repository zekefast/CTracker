require "test_helper"


class CollectionTest < ActiveSupport::TestCase
  should belong_to(:countries_currency)
  should belong_to(:user)
  should have_one(:country).through(:countries_currency)
  should have_one(:currency).through(:countries_currency)

  should validate_presence_of(:countries_currency)
  should validate_presence_of(:user)
end
