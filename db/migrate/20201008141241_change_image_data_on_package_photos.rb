class ChangeImageDataOnPackagePhotos < ActiveRecord::Migration[6.0]
  def change
    change_column :package_photos, :image_data, :jsonb, using: "image_data::jsonb"
  end
end
