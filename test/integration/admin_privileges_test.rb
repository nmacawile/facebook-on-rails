require 'test_helper'

class AdminPrivilegesTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin)
    @non_admin = users(:user1)
    @post = posts(:post1)
    @comment = comments(:comment1)
  end
  
  test "admin should be able to delete any post" do
    sign_in @admin
    assert_difference "Post.count", -1 do
      delete post_path @post
    end
  end
  
  test "admin should be able to delete any comment" do
    sign_in @admin
    assert_difference "Comment.count", -1 do
      delete comment_path @comment
    end
  end
end
