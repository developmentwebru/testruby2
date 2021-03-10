class Shipment < ApplicationRecord
  enum status: [ :preparing, :in_transit, :arrived ], _prefix: true

  has_many :packages, dependent: :destroy
  has_many :users, -> { distinct }, through: :packages
  has_many :guests, -> { distinct }, through: :packages

  validate :has_pending_packages, on: :create
  before_create :insert_packages

  private
    def has_pending_packages
      errors.add(:shipment_packages, "Need at least 1 package") if Package.pending.count == 0
    end

    def insert_packages
      self.packages << Package.pending
    end
end
