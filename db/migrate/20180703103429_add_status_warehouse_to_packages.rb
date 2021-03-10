class AddStatusWarehouseToPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :packages, :status_warehouse, :integer, default: 0
  end
end
