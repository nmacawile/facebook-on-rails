require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @notification = notifications(:notification1)
    @owner = users(:notif_owner)
    @actor = users(:notif_actor)
  end
  
  test "#show should redirect to notifications path if not the owner" do
    sign_in @actor
    assert_no_difference "@owner.notifications.count" do
      get notification_path(@notification)
    end
    assert_redirected_to notifications_path
  end
  
  test "#show should redirect to linkable path if the owner" do
    sign_in @owner
    assert_difference "@owner.notifications.count", -1 do
      get notification_path(@notification)
    end
    assert_redirected_to @notification.linkable
  end
  
  test "#delete should not change the notifications count if the owner is not signed in" do
    sign_in @actor
    assert_no_difference "@owner.notifications.count" do
      delete notification_path(@notification)
    end
    assert_redirected_to notifications_path
  end
  
  test "#delete should reduce the notifications count if the owner is signed in" do
    sign_in @owner
    assert_difference "@owner.notifications.count", -1 do
      delete notification_path(@notification)
    end
    assert_redirected_to notifications_path
  end
end
