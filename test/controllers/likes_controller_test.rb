require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:post2)
    @page_owner = users(:user4)
    @like = likes(:like1) # user5 likes his own post on user4's page
    @liker = users(:user5)
    @comment = comments(:comment1)
  end
  
  test "#create should require login" do
    post like_path(likeable_id: @post.id, likeable_type: "Post")
    assert_redirected_to new_user_session_path
  end
  
  test "#create should like the post on success" do
    sign_in @page_owner
    assert_difference "@post.likes.count", 1 do
      post like_path(likeable_id: @post.id, likeable_type: "Post")
    end
  end
  
  test "#create should like the comment on success" do
    sign_in @page_owner
    assert_difference "@comment.likes.count", 1 do
      post like_path(likeable_id: @comment.id, likeable_type: "Comment")
    end
  end
  
  test "#create should fail if the liker already likes the object" do
    sign_in @liker
    assert_no_difference "@post.likes.count" do
      post like_path(likeable_id: @post.id, likeable_type: "Post")
    end
  end
  
  test "#create should fail if the likeable_type param is neither 'Post' nor 'Comment'" do
    sign_in @page_owner
    assert_no_difference "@post.likes.count" do
      post like_path(likeable_id: @post.id, likeable_type: "Psot")
    end
    assert_redirected_to root_url
  end 
  
  test "#destroy should require login" do
    delete unlike_path(likeable_id: @post.id, likeable_type: "Post")
    assert_redirected_to new_user_session_path  
  end
  
  test "#destroy should unlike the object on success" do
    sign_in @liker
    assert_difference "@post.likes.count", -1 do
      delete unlike_path(likeable_id: @post.id, likeable_type: "Post")
    end
  end
end
