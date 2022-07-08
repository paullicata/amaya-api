class Book < ApplicationRecord
  validates_presence_of :title, :author_id, :grade_level
  belongs_to :author
end
