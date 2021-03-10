class AddReceivedAtToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :received_at, :datetime
  end
end
