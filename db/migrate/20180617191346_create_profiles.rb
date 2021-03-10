class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :city
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
