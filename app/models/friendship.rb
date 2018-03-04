class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  
  scope :between, -> (user1, user2) { where(user_id: user1, friend_id: user2).first }
  
  validates :user_id, uniqueness: { scope: :friend_id }
  validate :avoid_befriending_self
  
  private
  
    def avoid_befriending_self
      errors.add(:user_id, "cannot befriend itself.") if user_id == friend_id
    end
end