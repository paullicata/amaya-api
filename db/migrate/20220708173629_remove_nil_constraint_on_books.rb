class RemoveNilConstraintOnBooks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :books, :author_id, false
    change_column_null :books, :copyright, true

  end
end
