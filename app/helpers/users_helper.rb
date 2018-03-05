module UsersHelper
  
  def friendship_action_links(user)
    if user != current_user
      if friendship = Friendship.fetch(current_user, user)
        link_to "Remove as Friend", friendship_path(friendship), method: :delete, data: { confirm: "Are you sure?" } 
      elsif friend_request_out = FriendRequest.fetch(current_user, user)
        link_to "Cancel Friend Request", friend_request_path(friend_request_out), method: :delete, data: { confirm: "Are you sure?" } 
      elsif friend_request_in = FriendRequest.fetch(user, current_user)
        link_to("Confirm as Friend", friendships_path(id: user.id), method: :post) << " ".html_safe << 
        link_to("Reject Request", friend_request_path(friend_request_in), method: :delete, data: { confirm: "Are you sure?" })
      else
        link_to "Add as Friend", friend_requests_path(id: user.id), method: :post
      end
    end
  end
end
