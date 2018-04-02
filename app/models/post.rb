class Post < ApplicationRecord
  
  before_validation do
    self.body = ActionController::Base.helpers.strip_tags body
  end
  
  before_validation do
    self.body = body.strip.gsub(/\R{2,}/, "\r\n\r\n").gsub(/\R/, "\r\n")
  end
  
  before_save do
    self.body = body.gsub(/@(\w{1,20})/, "<a href=\"/user/\\1\">@\\1</a>")
  end
  
  after_create do
    owner.notify!(author, :post, self)
  end
  
  after_save do
    mentions = body.scan(/@(\w{1,20})/).flatten
    
    users_mentioned = User.where_username(mentions)
    users_mentioned.each do |user|
      user.notify!(author, :mention, self) unless user == owner
    end
  end
  
  belongs_to :user
  belongs_to :poster, class_name: "User"
  has_many :comments, dependent: :destroy
  
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes
  
  has_many :notifications_linked, class_name: "Notification",
                                  as: :linkable,
                                  dependent: :destroy
  
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
