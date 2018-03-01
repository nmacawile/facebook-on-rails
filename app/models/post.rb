class Post < ApplicationRecord
  belongs_to :user
  
  validates :body, length: { maximum: 1000 }
end
