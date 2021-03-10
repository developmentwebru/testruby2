class RemoveSingletonGuardFromShipmentNextDates < ActiveRecord::Migration[5.2]
  def up
    remove_column :shipment_next_dates, :singleton_guard, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
