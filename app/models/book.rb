class Book < ApplicationRecord
  belongs_to :author
  validates_presence_of :title, :author_id, :copyright
end
