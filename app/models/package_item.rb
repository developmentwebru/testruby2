class PackageItem < ApplicationRecord
  belongs_to :package, touch: true

  validates :description, :price, :qty, presence: true
  validates :price, numericality: {
    greater_than_or_equal_to: 0.99,
    less_than_or_equal_to: 10000
  }
  validates :qty, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 50
  }

  after_initialize { self.qty ||= 1 }
end
