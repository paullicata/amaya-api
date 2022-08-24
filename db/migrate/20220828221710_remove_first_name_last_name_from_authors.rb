class RemoveFirstNameLastNameFromAuthors < ActiveRecord::Migration[6.0]
  def change
    remove_column :authors, :first_name, :string
    remove_column :authors, :last_name, :string
    add_column :authors, :name, :string
  end
end
