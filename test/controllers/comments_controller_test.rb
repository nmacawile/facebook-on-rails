require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @comment = comments(:comment2)
    @commenter = users(:user1)
    @page_owner = users(:user4)
    @post = posts(:post2)
  end
  
  test "#edit, not signed in" do
    get edit_comment_path @comment
    assert_redirected_to new_user_session_path
  end
  
  test "#edit, commenter signed in" do
    sign_in @commenter
    get edit_comment_path @comment
    assert_response :success
    assert_template :edit
  end
  
  test "#edit, commenter signed in, no longer friends with page owner" do
    sign_in users(:user2)
    get edit_comment_path comments(:comment3)
    assert_redirected_to @post
  end
  
  test "#edit, signed in but not the commenter" do
    sign_in @page_owner
    get edit_comment_path @comment
    assert_redirected_to @post
    assert_not flash.empty?
  end
  
  test "#update, not signed in" do
    patch comment_path(@comment, params: { comment: { body: "updated comment" } })
    assert_redirected_to new_user_session_path
  end
  
  test "#update, commenter signed in" do
    sign_in @commenter
    patch comment_path(@comment, params: { comment: { body: "updated comment" } })
    assert_redirected_to @post
    follow_redirect!
    assert_match "updated comment", response.body
  end
  
  test "#update, commenter signed in, not friends anymore" do
    sign_in users(:user2)
    patch comment_path(comments(:comment3), params: { comment: { body: "updated comment" } })
    assert_redirected_to @post
    follow_redirect!
    assert_no_match "updated comment", response.body
  end
  
  test "#update, signed in but not the commenter" do
    sign_in @page_owner
    patch comment_path(@comment, params: { comment: { body: "updated comment" } })
    assert_redirected_to @post
    follow_redirect!
    assert_not flash.empty?
    assert_no_match "updated comment", response.body
  end
  
  test "#create, not signed in" do
    assert_no_difference "@post.comments.count" do
      post post_comments_path(@post, params: { comment: { body: "new comment" } })
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#create, owner signed in" do
    sign_in @page_owner
    assert_difference "@post.comments.count", 1 do
      post post_comments_path(@post, params: { comment: { body: "new comment" } })
    end
    assert_redirected_to @post
  end
  
  test "#create, user signed in, not a friend of page owner" do
    sign_in users(:user2)
    assert_no_difference "@post.comments.count" do
      post post_comments_path(@post, params: { comment: { body: "new comment" } })
    end
    assert_redirected_to @post
  end
  
  test "#create, user signed in, friend of page owner" do
    sign_in @commenter
    assert_difference "@post.comments.count", 1 do
      post post_comments_path(@post, params: { comment: { body: "new comment" } })
    end
    assert_redirected_to @post
  end
  
  test "#delete, not signed in" do
    assert_no_difference "@post.comments.count" do
      delete comment_path @comment
    end
    assert_redirected_to new_user_session_path
  end
  
  test "#delete, page owner signed in" do
    sign_in @page_owner
    assert_difference "@post.comments.count", -1 do
      delete comment_path @comment
    end
    assert_redirected_to @post
  end
  
  test "#delete, commenter signed in" do
    sign_in @commenter
    assert_difference "@post.comments.count", -1 do
      delete comment_path @comment
    end
    assert_redirected_to @post
  end
  
  test "#delete, neither commenter nor page owner signed in" do
    sign_in users(:user3)
    assert_no_difference "@post.comments.count" do
      delete comment_path @comment
    end
    assert_redirected_to @post
    assert_not flash.empty?
  end
end
