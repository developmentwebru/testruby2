class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|

      t.timestamps
    end
  end
end
