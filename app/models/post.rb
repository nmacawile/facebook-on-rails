class Post < ApplicationRecord
  belongs_to :user
  belongs_to :poster, class_name: "User"
  
  default_scope { order(id: :desc) }
  
  validates :body, length: { maximum: 1000 }
end
