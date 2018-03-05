module FriendshipsHelper

  def make_friends(user1, user2)
    if Friendship.new(user: user1, friend: user2).valid?
      current_user.add_as_friend! user2
      flash[:sucess] = "You are now friends with #{user2.username}."
    else
      flash[:danger] = "There was a problem."
    end
    redirect_to user2
  end
end
