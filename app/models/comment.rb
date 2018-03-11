class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :likes, as: :likeable
  has_many :likers, through: :likes
  
  default_scope { order(:id) }
  
  validates :body, length: { maximum: 255 }
end
