class AddGraToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :guided_reading_level, :string
  end
end
