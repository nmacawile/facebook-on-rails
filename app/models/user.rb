class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
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
end
