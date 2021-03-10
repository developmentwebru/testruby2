module Carrier
  extend ActiveSupport::Concern

  included do
    enum carrier: [:other, :dhl, :fedex, :ups, :usps], _prefix: true
    before_save :set_carrier, prepend: true
  end

  def set_carrier
    tracking_data = TrackingNumber.new(self.tracking)

    case tracking_data.carrier
    when :dhl
      self.carrier = :dhl
    when :fedex
      self.carrier = :fedex
    when :ups
      self.carrier = :ups
    when :usps
      self.carrier = :usps
    else
      self.carrier = :other
    end
  end
end
