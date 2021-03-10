class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
