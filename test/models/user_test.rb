require "test_helper"


class UserTest < ActiveSupport::TestCase
  should have_many(:collections)
  should have_many(:countries_currencies).through(:collections)

  should validate_presence_of(:email)
  should allow_value("ab@example.com").for(:email)
  should_not allow_value("abc").for(:email)

  should validate_presence_of(:password)
  should validate_confirmation_of(:password)
  should ensure_length_of(:password).is_at_least(8).is_at_most(128)
end
