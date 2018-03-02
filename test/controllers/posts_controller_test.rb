require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  
  test "#edit" do
    post = posts(:post1)
    get edit_post_path post
    assert_response :success
  end
  
  test "#update" do
    post = posts(:post1)
    patch post_path(post, params: { post: { body: "new post" } })
    assert_redirected_to user_path("foobar")
  end
  
  test "#create" do
    assert_difference "User.find_by(username: 'foobar').posts.count", 1 do
      post user_posts_path("foobar", params: { post: { body: "new post" } })
    end
    assert_redirected_to user_path("foobar")
  end
  
  test "#delete" do
    post = posts(:post1)
    assert_difference "User.find_by(username: 'foobar').posts.count", -1 do
      delete post_path(post)
    end
    assert_redirected_to user_path("foobar")
  end
end
