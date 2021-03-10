class CreatePackagePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :package_photos do |t|
      t.text :image_data
      t.references :package, null: false, foreign_key: true

      t.timestamps
    end
  end
end
