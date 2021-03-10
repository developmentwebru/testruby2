class AddUniqIndexToAdminAutocompletePackageItemDescription < ActiveRecord::Migration[6.0]
  def change
    add_index :admin_autocomplete_package_item_descriptions, :value, unique: true
  end
end
