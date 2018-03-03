require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:user1)
    @post = posts(:post1)
    @comment = Comment.new(user: @user, post: @post, body: "Hello world!")
  end
  
  test "should be valid" do
    assert @comment.valid?
  end
  
  test "should not exceed 255 characters" do
    @comment.body = "s" * 256
    assert_not @comment.valid?
  end
end