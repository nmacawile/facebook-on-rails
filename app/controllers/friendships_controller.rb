class FriendshipsController < ApplicationController
    
  before_action :authenticate_user!
  before_action :load_friend_to_add, only: :create
  before_action :require_friend_request, only: :create
  before_action :friendship_exists, only: :destroy
  before_action :load_friendship, only: :destroy
  before_action :user_involved_only, only: :destroy
  
  def create
    make_friends(current_user, @friend_to_add)
  end
  
  def destroy
    @user.unfriend! @friend
    flash[:danger] = "You have unfriended #{@friend.username}."
    redirect_to @friend
  end
  
  private

    def load_friend_to_add
      @friend_to_add = User.find(params[:id])
    end

    def require_friend_request
      unless FriendRequest.exists?(user_id: params[:id], friend_id: current_user.id)
        flash[:danger] = "You need a friend request from this user."
        redirect_to @friend_to_add
      end
    end
    
    def friendship_exists
      unless Friendship.exists?(params[:id])
        flash[:danger] = "Could not find the user in your friends list."
        redirect_to current_user
      end
    end
  
    def load_friendship
      @friendship = Friendship.find(params[:id])
      @friend = @friendship.friend
      @user = @friendship.user
    end
  
    def user_involved_only
      unless @user == current_user
        flash[:danger] = "You are not authorized to do that."
        redirect_to @friend
      end
    end
end
