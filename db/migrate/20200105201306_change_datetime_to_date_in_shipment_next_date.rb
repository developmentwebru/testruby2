class ChangeDatetimeToDateInShipmentNextDate < ActiveRecord::Migration[6.0]
  def change
    change_column :shipment_next_dates, :date, :date
  end
end
