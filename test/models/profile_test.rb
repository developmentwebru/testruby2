require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @profile = profiles(:kim)
  end

  test "first_name should present" do
    @profile.first_name = nil
    assert_not @profile.valid?
  end

  test "last_name should present" do
    @profile.last_name = nil
    assert_not @profile.valid?
  end

  test "phone should present" do
    @profile.phone = nil
    assert_not @profile.valid?
  end

  test "address should be present" do
    @profile.address = nil
    assert_not @profile.valid?
  end

  test "city should present" do
    @profile.city = nil
    assert_not @profile.valid?
  end
end
