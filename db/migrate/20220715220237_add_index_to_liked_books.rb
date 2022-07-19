class AddIndexToLikedBooks < ActiveRecord::Migration[6.0]
  def change
    add_index :liked_books, :user_id
    add_index :liked_books, [:user_id, :book_id], unique: true
  end
end
