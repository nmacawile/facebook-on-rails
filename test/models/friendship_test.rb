require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @friend = users(:user2)
    @friendship = Friendship.new(user: @user, friend: @friend)
  end
  
  test "should be valid" do
    assert @friendship.valid?
  end
  
  test "should not have a duplicate" do
    duplicate = @friendship.dup
    duplicate.save
    assert_not @friendship.valid?
  end
  
  test "should not point to itself" do
    @friendship.friend = @user
    assert_not @friendship.valid?
  end
end
