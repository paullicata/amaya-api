class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :copyright, null: false
      t.string :grade_level, null: false
      t.string :genre
      t.text :description
      t.text :cover, null: false, default: "https://sciendo.com/product-not-found.png"

      t.timestamps
    end
  end
end
