class Package < ApplicationRecord
  include PgSearch::Model
  include Carrier

  enum status_warehouse: [ :in_transit, :delivered ], _prefix: true

  belongs_to :user, optional: true
  has_one :profile, through: :user # Search users by first and last name
  belongs_to :guest, optional: true
  belongs_to :shipment, optional: true

  has_many :package_photos, dependent: :destroy
  accepts_nested_attributes_for :package_photos, allow_destroy: true, reject_if: proc { |a| a[:image].blank? }

  has_many :package_items, inverse_of: :package, dependent: :destroy

  pg_search_scope :search_by_name,
    associated_against: {
      profile: { first_name: "B", last_name: "A" },
      guest: { first_name: "B", last_name: "A" }
    },
    using: {
      tsearch: { prefix: true }
    }

  validates :tracking, presence: true, uniqueness: true
  validates :weight, presence: true,
            numericality: { greater_than_or_equal_to: 0.1, less_than_or_equal_to: 1000 }, on: :admin
  validates :package_items, presence: true

  accepts_nested_attributes_for :guest
  accepts_nested_attributes_for :package_items, allow_destroy: true

  before_validation :tracking_remove_whitespace, if: Proc.new { |p| p.tracking }
  before_validation :tracking_upcase, if: Proc.new { |p| p.tracking }
  before_save :find_or_initialize_guest, prepend: true, if: Proc.new { |p| p.guest }
  before_save :set_processed_at, if: Proc.new { |p| p.weight && !p.processed_at }
  before_save :set_status_warehouse_as_delivered, if: Proc.new { |p| p.weight && !p.status_warehouse_delivered? }

  scope :pending, -> { status_warehouse_delivered.where.not(weight: nil).where(shipment: nil) }
  scope :dhl,   -> { carrier_dhl }
  scope :fedex, -> { carrier_fedex }
  scope :ups,   -> { carrier_ups }
  scope :usps,  -> { carrier_usps }
  scope :other, -> { carrier_other }

  scope :expected, -> { status_warehouse_in_transit }
  scope :warehouse, -> { status_warehouse_delivered.where(shipment: nil) }
  scope :in_transit, -> { includes(:shipment).where(shipments: { status: [0, 1] }) }
  scope :arrived, -> { includes(:shipment).where(shipments: { status: "arrived" }) }

  def self.pending_weight
    pending.sum(:weight)
  end

  def self.pending_items_price
    pending.joins(:package_items).sum("package_items.price")
  end

  def self.items_price
    joins(:package_items).sum("package_items.price")
  end

  def items_price
    package_items.sum(&:price)
  end

  private
    def tracking_remove_whitespace
      self.tracking = self.tracking.gsub(/[[:space:]]/, "").gsub(/\p{Cf}/, "")
    end

    def tracking_upcase
      self.tracking = self.tracking.upcase
    end

    def find_or_initialize_guest
      self.guest = Guest.find_or_initialize_by(
        first_name: self.guest.first_name,
        last_name:  self.guest.last_name
      )
    end

    def set_processed_at
      self.processed_at = Time.current
    end

    def set_status_warehouse_as_delivered
      self.status_warehouse = :delivered
    end
end
