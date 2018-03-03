require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    poster = users(:user1)
    @post = poster.posts.build(poster: poster,
                               body: "thequickbrownfoxjumpsoverthelazydog")
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "body should be limited to 1000 characters" do
    @post.body = "a" * 1001
    assert_not @post.valid?
  end
end
