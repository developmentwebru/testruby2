require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  setup do
    @package = packages(:one)
  end

  test "tracking should be present" do
    @package.tracking = nil
    assert_not @package.valid?
  end

  test "tracking should be uniq" do
    package_copy = @package.dup
    assert_not package_copy.save
  end

  test "weight should be present (:admin context)" do
    @package.weight = 1
    assert @package.valid?(:admin)

    @package.weight = nil
    assert_not @package.valid?(:admin)
  end

  test "weight must be at least 0.1 (:admin context)" do
    @package.weight = 0.1
    assert @package.valid?(:admin)

    @package.weight = 0.09
    assert_not @package.valid?(:admin)
  end

  test "weight must be no more than 1000 (:admin context)" do
    @package.weight = 1000
    assert @package.valid?(:admin)

    @package.weight = 1000.00001
    assert_not @package.valid?(:admin)
  end
end
