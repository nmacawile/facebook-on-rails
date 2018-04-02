require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  
  def setup
    @notification = Notification.new(actor: users(:user5),
                                     receipient: users(:user4),
                                     linkable_type: "Post",
                                     linkable: posts(:post2),
                                     action: :post)
  end
  
  test "should be valid" do
    assert @notification.valid?
  end
 
  test "should have an actor" do
    @notification.actor = nil
    assert_not @notification.valid?
  end
 
  test "should have a receipient" do
    @notification.receipient = nil
    assert_not @notification.valid?
  end
 
  test "should have a linkable" do
    @notification.linkable = nil
    assert_not @notification.valid?
  end
  
  test "should have a linkable_type" do
    @notification.linkable_type = nil
    assert_not @notification.valid?
  end
 
  test "actor and receipient should not be the same" do
    @notification.actor = users(:user4)
    @notification.receipient = users(:user4)
    assert_not @notification.valid?
  end
end
 