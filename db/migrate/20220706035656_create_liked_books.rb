class CreateLikedBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :liked_books do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false

      t.timestamps
    end
  end
end
