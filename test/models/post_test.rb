require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    poster = users(:user1)
    @bob = users(:user2)
    @pat = users(:user3)
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
  
  test "should not be blank" do
    @post.body = "   "
    assert_not @post.valid?
  end
  
  test "should be sanitized of any tags before validation" do
    @post.body = "<script></script><em></em><br /><br ><a href='#'>A</a>"
    @post.save
    assert_equal @post.reload.body, "A"
  end
  
  test "should reduce consecutive line breaks before validation" do
    @post.body = "\r\nA\r\n\r\n\r\n\r\n\r\n\r\nB\r\nC\r\n"
    @post.save
    assert_equal @post.reload.body, "A\r\n\r\nB\r\nC"
  end
end
