require 'test_helper'

class PackageItemTest < ActiveSupport::TestCase
  setup do
    @package_item = package_items(:one)
  end

  test "description should present" do
    @package_item.description = nil
    assert_not @package_item.valid?
  end

  test "price should present" do
    @package_item.price = nil
    assert_not @package_item.valid?
  end

  test "price should be at least 0.99" do
    @package_item.price = 0.99
    assert @package_item.valid?

    @package_item.price = 0
    assert_not @package_item.valid?

    @package_item.price = 0.98
    assert_not @package_item.valid?
  end

  test "price should be max 10_000" do
    @package_item.price = 10_000
    assert @package_item.valid?

    @package_item.price = 9999.99
    assert @package_item.valid?

    @package_item.price = 10_001
    assert_not @package_item.valid?

    @package_item.price = 10_000.00000001
    assert_not @package_item.valid?
  end

  test "qty should be present" do
    @package_item.qty = nil
    assert_not @package_item.valid?
  end

  test "qty default is 1" do
    package_item = PackageItem.new
    assert_equal package_item.qty, 1
  end

  test "qty should be only integer" do
    @package_item.qty = 0.5
    assert_not @package_item.valid?
  end

  test "qty should be at least 1" do
    @package_item.qty = 1
    assert @package_item.valid?

    @package_item.qty = 0
    assert_not @package_item.valid?
  end

  test "qty should be no more than 50" do
    @package_item.qty = 50
    assert @package_item.valid?

    @package_item.qty = 49
    assert @package_item.valid?

    @package_item.qty = 51
    assert_not @package_item.valid?
  end
end
