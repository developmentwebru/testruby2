class ShipmentNextDate < ApplicationRecord
  validate :single_instance, on: :create
  validates :date, presence: true

  private
    def single_instance
      errors.add(:count, "1 instance allowed") if ShipmentNextDate.count == 1
    end
end
