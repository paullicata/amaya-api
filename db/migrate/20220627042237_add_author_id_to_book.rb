class AddAuthorIdToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :author_id, :integer
    add_foreign_key :books, :authors
  end
end
