require 'test_helper'

class NotificationsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user4)
    @friend1 = users(:user1)
    @friend2 = users(:user5)
    @post = posts(:post2) # friend2's post on user's page
    @future_friend = users(:user2)
  end
  
  test "should notify the page owner when a friend posts on his page" do
    sign_in @friend1
    assert_difference "@user.notifications.count", 1 do
      post user_posts_path(@user), params: { post: { body: "Sup dude?" } }
    end
  end
  
  test "should notify the page owner when a friend comments on a post on his page" do
    sign_in @friend1
    assert_difference "@user.notifications.count", 1 do
      post post_comments_path(@post), params: { comment: { body: "I like trains!" } }
    end
  end
  
  test "should notify the poster when a friend comments on a his post on another friend's page" do
    sign_in @friend1
    assert_difference "@friend2.notifications.count", 1 do
      post post_comments_path(@post), params: { comment: { body: "I like trains!" } }
    end
  end
  
  test "should notify the user only once for the same action on the same object" do
    sign_in @friend1
    assert_difference "@user.notifications.count", 1 do
      post post_comments_path(@post), params: { comment: { body: "I like trains!" } }
      post post_comments_path(@post), params: { comment: { body: "I like boats!" } }
      post post_comments_path(@post), params: { comment: { body: "I like planes!" } }
    end
  end
  
  test "should notify the user when he is mentioned in a post" do
    sign_in @friend1
    assert_difference "@user.notifications.count", 1 do
      post user_posts_path(@friend1), params: { post: { body: "@test1" } }
    end
  end
  
  test "should notify the user when he is mentioned in a post (case insensitive)" do
    sign_in @friend1
    assert_difference "@user.notifications.count", 1 do
      post user_posts_path(@friend1), params: { post: { body: "@tEsT1" } }
    end
  end
  
  test "should notify multiple users mentioned in a post, skip invalid ones" do
    sign_in @user
    assert_difference "Notification.count", 2 do
      post user_posts_path(@user), params: { post: { body: "@test2 @foobar @does_not_exist" } }
    end
  end
  
  test "should notify the page owner only once when a friend posts on his page and mentions him in the same post" do
    sign_in @friend1
    assert_difference "@user.notifications.count", 1 do
      post user_posts_path(@user), params: { post: { body: "Sup @test1" } }
    end
  end
  
  test "should notify the user when he receives a friend request" do
    sign_in @future_friend
    assert_difference "@user.notifications.count", 1 do
      post friend_requests_path, params: { id: @user.id }
    end
  end
  
  test "should notify the user when a friend request he sent is accepted" do
    sign_in @future_friend
    post friend_requests_path, params: { id: @user.id }
    delete destroy_user_session_path
    
    sign_in @user
    assert_difference "@future_friend.notifications.count", 1 do
      post friendships_path, params: { id: @future_friend.id }
    end
  end
end
