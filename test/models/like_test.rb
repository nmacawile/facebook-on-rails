require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
  def setup
    post = posts(:post1)
    liker = users(:user1)
    @like = Like.new(liker: liker, likeable: post, likeable_type: "Post")
    
  end
  
  test "should be valid" do
    assert @like.valid?
  end
  
  test "should have likeable_type" do
    @like.likeable_type = ""
    assert_not @like.valid?
  end
  
  test "should avoid duplication" do
    like_copy = @like.dup
    like_copy.save
    assert_not @like.valid?
  end
end
