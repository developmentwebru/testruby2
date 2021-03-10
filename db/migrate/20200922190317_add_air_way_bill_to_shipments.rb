class AddAirWayBillToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :air_waybill, :string
  end
end
