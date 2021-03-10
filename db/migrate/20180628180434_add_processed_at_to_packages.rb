class AddProcessedAtToPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :packages, :processed_at, :datetime
  end
end
