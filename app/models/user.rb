require 'uri_validator'

class User < ApplicationRecord
  
  before_save do
    self.first_name = first_name.strip.squeeze(" ")
    self.last_name = last_name.strip.squeeze(" ")
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  
  mount_uploader :avatar, AvatarUploader
  mount_uploader :banner, BannerUploader
         
  has_many :posts, dependent: :destroy
  has_many :posts_authored, class_name: "Post",
                            foreign_key: :poster_id,
                            dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  
  has_many :reverse_friendships, class_name: "Friendship",
                                 foreign_key: :friend_id,
                                 dependent: :destroy
  has_many :reverse_friends, through: :reverse_friendships,
                             source: :user

  has_many :friend_requests_sent, class_name: "FriendRequest",
                                  dependent: :destroy
  has_many :friends_pending, through: :friend_requests_sent,
                             source: :friend

  has_many :friend_requests_received, class_name: "FriendRequest",
                                      foreign_key: :friend_id,
                                      dependent: :destroy
  has_many :friends_to_confirm, through: :friend_requests_received,
                                source: :user
                                
  has_many :likings, class_name: "Like",
                     foreign_key: :liker_id,
                     dependent: :destroy

  has_many :posts_liked, through: :likings,
                         source: :likeable,
                         source_type: "Post"
  
  has_many :comments_liked, through: :likings,
                            source: :likeable,
                            source_type: "Comment"
                            
  has_many :notifications, foreign_key: :receipient_id,
                           dependent: :destroy
                           
  has_many :notifications_linked, class_name: "Notification",
                                  as: :linkable,
                                  dependent: :destroy
  
  validates :last_name, presence: true,
                        length: { maximum: 50 },
                        format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }
  validates :first_name, presence: true,
                         length: { maximum: 50 },
                         format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }
  validates :gender, presence: true
  validates :birthday, presence: true
  validates :username, presence: true,
                       length: { maximum: 20 },
                       format: { with: /\A[\w]+\z/},
                       uniqueness: { case_sensitive: false }
                       
  validates :remote_avatar_url, allow_blank: true,
                                uri: { 
                                  format: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
                                }
                                
  validates :remote_banner_url, allow_blank: true,
                                uri: { 
                                  format: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
                                }
  
  enum gender: [:male, :female, :other, :not_telling]
  
  def add_as_friend!(user)
    self.friends << user
    self.reverse_friends << user
    fr = FriendRequest.fetch(user, self)
    if fr
      fr.destroy
    end
  end
  
  def unfriend!(user)
    Friendship.fetch(self, user).destroy
    Friendship.fetch(user, self).destroy
  end
  
  def friends_with?(user)
    friends.include? user
  end
  
  def notify!(actor, action, notifiable, linkable = nil)
    linkable ||= actor
    Notification.create(actor: actor,
                        receipient: self,
                        action: action,
                        notifiable: notifiable,
                        linkable: linkable)
  end
  
  def to_param
    username
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def admin?
    admin
  end
  
  def self.search(query)
    return User.none if query.blank?
    if query =~ /@/
      where(email: query)
    else
      where("concat_ws(' ', first_name, last_name, first_name, username) ILIKE ?", "%#{query.squish}%")
    end
  end
  
  def self.find_by_username(username)
    where("LOWER(username) = ?", username.downcase).first
  end
  
  def self.where_username(usernames)
    usernames.map! { |username| username.downcase }
    where("LOWER(username) IN (?)", usernames)
  end
  
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    
    # unless user
    #  user = User.new(email: data['email'])
    # end
    user
  end
end
