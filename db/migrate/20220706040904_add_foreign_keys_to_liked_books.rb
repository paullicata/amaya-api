class AddForeignKeysToLikedBooks < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :liked_books, :books
    add_foreign_key :liked_books, :users
  end
end
