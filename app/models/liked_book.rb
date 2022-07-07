class LikedBook < ApplicationRecord
  validates_presence_of :user_id, :book_id
end
