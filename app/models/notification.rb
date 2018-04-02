class Notification < ApplicationRecord
  
  belongs_to :receipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :linkable, polymorphic: true
  
  default_scope { order(id: :desc) }
  
  enum action: [:post, :comment, :mention, :friend_request, :add]
  validates :actor, uniqueness: { scope: [:receipient_id, :linkable_id, :linkable_type, :action] }
  
  validate :avoid_notifying_itself
  
  private
  
    def avoid_notifying_itself
      errors.add(:actor_id, "cannot notify itself.") if actor_id == receipient_id
    end
end
