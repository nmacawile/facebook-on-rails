class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
         
  has_many :posts, dependent: :destroy
  has_many :posts_authored, class_name: "Post",
                            foreign_key: :poster_id,
                            dependent: :destroy
  has_many :comments, dependent: :destroy
         
  validates :last_name, presence: true,
                        length: { maximum: 50 }
  validates :first_name, presence: true,
                         length: { maximum: 50 }
  validates :gender, presence: true
  validates :birthday, presence: true
  validates :username, presence: true,
                       length: { maximum: 20 },
                       format: { with: /\A[\w]+\z/},
                       uniqueness: { case_sensitive: false }
  
  enum gender: [:male, :female, :other, :not_telling]
  
  def to_param
    username
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
