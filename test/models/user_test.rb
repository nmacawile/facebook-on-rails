require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(
              email: "walterwhite@greymatter.com",
              first_name: "Walter",
              last_name: "White",
              birthday: Date.parse("07/07/1959"),
              gender: :male,
              username: "Heisenberg",
              password: "walter",
              password_confirmation: "walter"
            )
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  # Presence
  
  test "first_name should be present" do
    @user.first_name = "  "
    assert_not @user.valid?
  end
  
  test "last_name should be present" do
    @user.last_name = "  "
    assert_not @user.valid?
  end
  
  test "username should be present" do
    @user.username = "  "
    assert_not @user.valid?
  end
  
  test "birthday should be present" do
    @user.birthday = "  "
    assert_not @user.valid?
  end
  
  # Character limit
  
  test "first_name should not exceed 50 chars" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end
  
  test "last_name should not exceed 50 chars" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end
  
  test "username should not exceed 20 chars" do
    @user.username = "a" * 21
    assert_not @user.valid?
  end
  
  # Username
  
  test "username should be unique" do
    fake_walt = @user.dup
    fake_walt[:email] = "notwalt@graymatter.com"
    fake_walt.save
    assert_not @user.valid?
  end
  
  test "username should be unique, disregarding case" do
    fake_walt = @user.dup
    fake_walt[:email] = "notwalt@graymatter.com"
    fake_walt[:username] = "heisenberg"
    fake_walt.save
    assert_not @user.valid?
  end
  
  test "username should not contain special symbols" do
    invalid_usernames = %w(
                          wa.lt
                          wa/lt
                          wa@lt
                          wa-lt
                          "wa lt"
                        )
    invalid_usernames.each do |uname|
      @user.username = uname
      assert_not @user.valid?
    end
  end
  
  test "username could contain alpha-numeric characters including underscores" do
    @user.username = "____123abc"
    assert @user.valid?
  end
  
  test "username characters should retain their cases" do
    new_uname = "_HeIsEnBeRg"
    @user.username = new_uname
    @user.save
    assert_equal @user.reload.username, new_uname 
  end
  
  test "should remove spaces from both ends of first_name" do
    @user.first_name = " Walt   "
    @user.save
    assert_equal @user.reload.first_name, "Walt"
  end
  
  test "should remove spaces from both ends of last_name" do
    @user.last_name = " White   "
    @user.save
    assert_equal @user.reload.last_name, "White"
  end
  
  test "should squeeze consecutive spaces in the first_name" do
    @user.first_name = "Wal  Ter"
    @user.save
    assert_equal @user.reload.first_name, "Wal Ter"
  end
  
  test "should squeeze consecutive spaces in the last_name" do
    @user.first_name = "Whi   Te"
    @user.save
    assert_equal @user.reload.first_name, "Whi Te"
  end
  
  test "should be valid first_names" do
    names = ["Ms. Jan Levinson-Gould",
             "Dr. Martin Luther King, Jr.",
             "Brett d'Arras-d'Haudracey",
             "Brüno",
             "John Doe",
             "Mary-Jo Jane Sally Smith"]
    names.each do |name|
      @user.first_name = name 
      assert @user.valid?
    end
  end
  
  test "should be valid last_names" do
    names = ["Ms. Jan Levinson-Gould",
             "Dr. Martin Luther King, Jr.",
             "Brett d'Arras-d'Haudracey",
             "Brüno",
             "John Doe",
             "Mary-Jo Jane Sally Smith"]
    names.each do |name|
      @user.last_name = name 
      assert @user.valid?
    end
  end
  
  test "should be invalid first_names" do
    names = ["Fatty Mc.Error$",
             "FA!L",
             "#arold Newm@n",
             "N4m3 w1th Numb3r5"]
             
    names.each do |name|
      @user.first_name = name 
      assert_not @user.valid?
    end
  end

  test "should be invalid last_names" do
    names = ["Fatty Mc.Error$",
             "FA!L",
             "#arold Newm@n",
             "N4m3 w1th Numb3r5"]
             
    names.each do |name|
      @user.last_name = name 
      assert_not @user.valid?
    end
  end
end
