require 'test_helper'

class DeleteNotificationDependentsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:notif_owner)
    @friend_request_sender = users(:user1)
    @post_to_delete = posts(:n_post)
    @comment_to_delete = comments(:n_comment)
    @friend_request_to_delete = friend_requests(:n_friend_request)
    @friendship_to_delete = friendships(:friendship4_2)
    sign_in @user
  end
  
  test "should delete post notifiables with their associated notifications" do
    assert_difference "@user.notifications.count", -1 do
      delete post_path @post_to_delete
    end
  end
  
  test "should delete comment notifiables with their associated notifications" do
    assert_difference "@user.notifications.count", -1 do
      delete comment_path @comment_to_delete
    end
  end
  
  test "should delete friend_request notifiables with their associated notifications" do
    assert_difference "@user.notifications.count", -1 do
      delete friend_request_path @friend_request_to_delete
    end
  end
  
  test "should delete friendship notifiables with their associated notifications" do
    assert_difference "@user.notifications.count", -1 do
      delete friendship_path @friendship_to_delete
    end
  end
end
