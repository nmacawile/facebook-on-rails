require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user1)
    @post = posts(:post1)
    @user2 = users(:user2)
    @post2 = posts(:post2) # User2's post on User1's page
  end
  
  test "#edit, not signed in" do
    get edit_post_path @post
    assert_redirected_to new_user_session_path
  end
  
  test "#edit, poster signed in" do
    sign_in @user
    get edit_post_path @post
    assert_response :success
    assert_template :edit
  end
  
  test "#edit, signed in but not the poster" do
    sign_in @user
    get edit_post_path @post2
    assert_redirected_to @user
    assert_not flash.empty?
  end
  
  test "#update, not signed in" do
    patch post_path(@post, params: { post: { body: "updated post" } })
    assert_redirected_to new_user_session_path
  end
  
  test "#update, poster signed in" do
    sign_in @user
    patch post_path(@post, params: { post: { body: "updated post" } })
    assert_redirected_to @user
    follow_redirect!
    assert_match "updated post", response.body
  end
  
  test "#update, signed in but not the poster" do
    sign_in @user
    patch post_path(@post2, params: { post: { body: "updated post" } })
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    assert_no_match "updated post", response.body
  end
  
  test "#create, not signed in" do
    assert_no_difference "User.find_by_username(@user.username).posts.count" do
      post user_posts_path(@user.username, params: { post: { body: "new post" } })
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#create, user signed in" do
    sign_in @user
    assert_difference "User.find_by_username(@user.username).posts.count", 1 do
      post user_posts_path(@user.username, params: { post: { body: "new post" } })
    end
    assert_redirected_to @user
  end
  
  test "#delete, not signed in" do
    assert_no_difference "User.find_by_username(@user.username).posts.count" do
      delete post_path @post
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#delete, user signed in" do
    sign_in @user
    assert_difference "User.find_by_username(@user.username).posts.count", -1 do
      delete post_path @post
    end
    assert_redirected_to @user
  end
  
  test "#delete, poster signed in" do
    sign_in @user2
    assert_difference "User.find_by_username(@user.username).posts.count", -1 do
      delete post_path @post2
    end
    assert_redirected_to @user
  end
  
  test "#delete, neither poster nor user signed in" do
    sign_in users(:user3)
    assert_no_difference "User.find_by_username(@user.username).posts.count" do
      delete post_path @post2
    end
    assert_redirected_to @user
    assert_not flash.empty?
  end
end
