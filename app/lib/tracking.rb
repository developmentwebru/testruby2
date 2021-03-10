module Tracking
  def self.sanitize(tracking_query)
    t = TrackingNumber.new(tracking_query)

    # Fedex SmartPost: Some users get tracking number with 9* prefix, some don't.
    # Search for both numbers with and without prefix when applicable
    fedex_smart_post_without_prefix = false

    # Fedex GSN
    if t.courier_code == :fedex && t.decode[:gsn]
      tracking = t.serial_number[2..-1] + t.check_digit
    # Fedex Ground (96)
    elsif t.courier_code == :fedex && t.decode[:scnc]
      tracking = t.serial_number + t.check_digit
    # USPS 91
    elsif t.courier_code == :usps && t.decode[:scnc]
      # Fedex SmartPost delivered by USPS
      if t.decode[:scnc] == "61" && t.decode[:service_type] == "29"
        fedex_smart_post_without_prefix = true # Set to true, so we search substring track too
      end
      tracking = t.serial_number + t.check_digit
    else
      tracking = tracking_query
    end

    {
      tracking: tracking,
      fedex_smart_post_without_prefix: fedex_smart_post_without_prefix
    }
  end
end
