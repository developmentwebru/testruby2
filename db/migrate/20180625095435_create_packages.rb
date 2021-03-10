class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :tracking
      t.decimal :weight, precision: 8, scale: 2
      t.references :user, foreign_key: true
      t.references :guest, foreign_key: true
      t.references :shipment, foreign_key: true

      t.timestamps
    end
    add_index :packages, :tracking, unique: true
  end
end
