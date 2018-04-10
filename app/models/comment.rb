class Comment < ApplicationRecord
  
  before_validation do
    self.body = ActionController::Base.helpers.strip_tags body
  end
  
  after_create do
    owner.notify!(author, :comment, self, post)
    post.author.notify!(author, :comment, self, post)
  end
  
  belongs_to :user
  belongs_to :post
  
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes
  
  has_many :notifications_associated_with, class_name: "Notification",
                                           as: :notifiable,
                                           dependent: :destroy
  
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
