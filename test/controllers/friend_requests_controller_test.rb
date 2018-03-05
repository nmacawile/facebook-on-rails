require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user1 = users(:user1) # has a pending request for user2
  	@user2 = users(:user2) # friends with user3
  	@user3 = users(:user3)
    @friend_request = friend_requests(:friend_request1)
  end

  test "#create should require login" do
  	assert_no_difference "FriendRequest.count" do
      post friend_requests_path(id: @user2.id)
    end
    assert_redirected_to new_user_session_path
  end

  test "#create should fail if there is already a pending request" do
  	sign_in @user1
  	assert_no_difference "FriendRequest.count" do
      post friend_requests_path(id: @user2.id)
    end
    assert_redirected_to @user2
  end

  test "#create should not allow sending a request to a user who is already a friend" do
    sign_in @user2
    assert_no_difference "FriendRequest.count" do
      post friend_requests_path(id: @user3.id)
    end
    assert_redirected_to @user3
  end

  test "#create should not allow user to send itself a request" do
    sign_in @user1
    assert_no_difference "FriendRequest.count" do
      post friend_requests_path(id: @user1.id)
    end
    assert_redirected_to @user1
  end
  
  test "#create should create a friend request on success" do
  	sign_in @user1
    assert_difference "FriendRequest.count", 1 do
      post friend_requests_path(id: @user3.id)
    end
    assert_redirected_to @user3
  end

  test "#create should add the friend instead if the friend has a pending friend request" do
    sign_in @user2
    assert_difference "Friendship.count", 2 do
      post friend_requests_path(id: @user1.id)
    end
    assert_redirected_to @user1
  end

  test "#create should delete the pending request if the friend has one" do
    sign_in @user2
    assert_difference "FriendRequest.count", -1 do
      post friend_requests_path(id: @user1.id)
    end
    assert_redirected_to @user1
  end

  test "#delete should require login" do
  	assert_no_difference "FriendRequest.count" do
      delete friend_request_path(@friend_request)
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#delete should allow the requester to destroy or cancel the request" do
  	sign_in @user1
  	assert_difference "FriendRequest.count", -1 do
      delete friend_request_path(@friend_request)
    end
    assert_redirected_to @user2
  end

  test "#delete should allow the requestee to destroy or reject the request" do
  	sign_in @user2
  	assert_difference "FriendRequest.count", -1 do
      delete friend_request_path(@friend_request)
    end
    assert_redirected_to @user2
  end

  test "#delete should not allow people other than the requestee or the requester to delete the request" do
  	sign_in @user3
  	assert_no_difference "FriendRequest.count" do
      delete friend_request_path(@friend_request)
    end
    assert_redirected_to @user2
  end

  test "#delete should fail if the friend request cannot be found" do
  	sign_in @user3
  	assert_no_difference "FriendRequest.count" do
      delete friend_request_path(0)
    end
    assert_redirected_to @user3
  end
end
