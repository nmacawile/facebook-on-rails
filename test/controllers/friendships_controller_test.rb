require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @spongebob = users(:user2)
    @patrick = users(:user3)
    @friendship = friendships(:friendship1)
    @not_friend = users(:user1)
  end
  
  test "#create should require login" do
    assert_no_difference "Friendship.count" do
      post friendships_path(id: @spongebob.id)
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#create should create two entries on success" do
    sign_in @spongebob
    assert_difference "Friendship.count", 2 do
      post friendships_path(id: @not_friend.id)
    end
    assert_redirected_to @not_friend
  end
  
  test "#create should not allow user to add itself" do
    sign_in @spongebob
    assert_no_difference "Friendship.count" do
      post friendships_path(id: @spongebob.id)
    end
    assert_redirected_to @spongebob
  end
  
  test "#create should not allow to add a user who is already a friend" do
    sign_in @spongebob
    assert_no_difference "Friendship.count" do
      post friendships_path(id: @patrick.id)
    end
    assert_redirected_to @patrick
  end
  
  test "#destroy should require login" do
    assert_no_difference "Friendship.count" do
      delete friendship_path(@friendship)
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#destroy should not allow deleting friendship between other people" do
    sign_in @not_friend
    assert_no_difference "Friendship.count" do
      delete friendship_path(@friendship)
    end
    assert_redirected_to @patrick
    assert_not flash.empty?
  end
  
  test "#destroy should redirect to user's page if no entry is found" do
    sign_in @spongebob
    assert_no_difference "Friendship.count" do
      delete friendship_path(id: 5)
    end
    assert_redirected_to @spongebob
    assert_not flash.empty?
  end
  
  test "#destroy should delete two friendship entries with a friend on success" do
    sign_in @spongebob
    assert_difference "Friendship.count", -2 do
      delete friendship_path(@friendship)
    end
    assert_redirected_to @patrick
  end
end
