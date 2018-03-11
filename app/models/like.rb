class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :likeable, polymorphic: true
  
  validates :likeable_id, uniqueness: { scope: [:liker_id, :likeable_type] }
end
