class Post < ApplicationRecord
  belongs_to :user
  belongs_to :poster, class_name: "User"
  has_many :comments, dependent: :destroy
  
  has_many :likes, as: :likeable
  has_many :likers, through: :likes
  
  default_scope { order(id: :desc) }
  
  validates :body, presence: true,
                   length: { maximum: 1000 }
  
  def owner
    user
  end
  
  def author
    poster
  end
end
