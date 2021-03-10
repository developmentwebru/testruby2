class AddStatusToShipments < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :status, :integer, default: 0
  end
end
