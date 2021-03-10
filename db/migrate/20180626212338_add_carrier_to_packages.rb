class AddCarrierToPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :packages, :carrier, :integer, default: 0
  end
end
