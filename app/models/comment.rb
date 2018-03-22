class Comment < ApplicationRecord
  
  before_validation do
    self.body = ActionController::Base.helpers.strip_tags body
  end
  
  belongs_to :user
  belongs_to :post
  
  has_many :likes, as: :likeable
  has_many :likers, through: :likes
  
  default_scope { order(:id) }
  
  validates :body, presence: true,
                   length: { maximum: 255 }
  
  def owner
    post.user
  end
  
  def author
    user
  end
end
