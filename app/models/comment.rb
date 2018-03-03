class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :body, length: { maximum: 255 }
end
