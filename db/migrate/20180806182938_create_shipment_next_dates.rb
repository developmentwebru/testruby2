class CreateShipmentNextDates < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_next_dates do |t|
      t.datetime :date
      t.integer :singleton_guard, null: false, default: 0

      t.timestamps
    end
    add_index :shipment_next_dates, :singleton_guard, unique: true
  end
end
