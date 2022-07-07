class Book < ApplicationRecord
  validates_presence_of :title, :author_id, :copyright
  belongs_to :author
end
