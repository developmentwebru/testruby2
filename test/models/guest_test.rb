require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  setup do
    @guest = guests(:one)
  end

  test "first_name should present" do
    @guest.first_name = nil
    assert_not @guest.valid?
  end

  test "last_name should present" do
    @guest.last_name = nil
    assert_not @guest.valid?
  end
end
