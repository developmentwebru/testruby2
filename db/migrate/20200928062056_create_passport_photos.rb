class CreatePassportPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :passport_photos do |t|
      t.jsonb :image_data
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
