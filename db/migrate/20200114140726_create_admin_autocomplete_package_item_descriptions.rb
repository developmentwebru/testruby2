class CreateAdminAutocompletePackageItemDescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_autocomplete_package_item_descriptions do |t|
      t.string :value, null: false

      t.timestamps
    end
  end
end
