module UsersHelper
  
  def friendship_action_links(user)
    return unless user_signed_in? && user != current_user
  
    if friendship = Friendship.fetch(current_user, user)
      link_with_icon(["fas", "user-times"],
                     "Remove as Friend",
                     friendship_path(friendship),
                       method: :delete,
                       data: { confirm: "Are you sure?" },
                       class: ["btn", "btn-danger", "btn-long"])
    elsif friend_request_out = FriendRequest.fetch(current_user, user)
      link_with_icon(["fas", "user-times"],
                      "Cancel Request",
                      friend_request_path(friend_request_out),
                        method: :delete,
                        data: { confirm: "Are you sure?" },
                        class: ["btn", "btn-warning", "btn-long"])
    elsif friend_request_in = FriendRequest.fetch(user, current_user)
      content_tag(:div,
                  link_with_icon(["fas", "check"],
                                 "Confirm",
                                 friendships_path(id: user.id),
                                   method: :post,
                                   class: ["btn", "btn-success", "btn-short"]) << 
                  link_with_icon(["fas", "times"],
                                  "Reject",
                                  friend_request_path(friend_request_in),
                                    method: :delete,
                                    data: { confirm: "Are you sure?" },
                                    class: ["btn", "btn-danger", "btn-short"]),
                  class: "btn-group")
    else
      link_with_icon(["fas", "user-plus"],
                     "Add as Friend",
                     friend_requests_path(id: user.id),
                       method: :post,
                       class: ["btn", "btn-primary", "btn-long"])
  
    end
  end
end
