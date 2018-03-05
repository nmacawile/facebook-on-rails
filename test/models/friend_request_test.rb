require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:user1)
    @user3 = users(:user3)
    @friend_request = FriendRequest.new(user: @user1, friend: @user3)
  end
  
  test "should be valid" do
    assert @friend_request.valid?
  end
  
  test "should not have a duplicate" do
    duplicate = @friend_request.dup
    duplicate.save
    assert_not @friend_request.valid?
  end
  
  test "should not point to itself" do
    @friend_request.friend = @user1
    assert_not @friend_request.valid?
  end

  test "should be invalid if already friends" do
    user2 = users(:user2) # friend of user2
    friend_request = FriendRequest.new(user: user2, friend: @user3)
    assert_not friend_request.valid?
  end
end
