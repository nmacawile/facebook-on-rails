class FriendshipsController < ApplicationController
    
  before_action :authenticate_user!
  before_action :friendship_exists, only: :destroy
  before_action :load_friendship, only: :destroy
  before_action :user_involved_only, only: :destroy
  
  def create
    friend = User.find(params[:id])
    if Friendship.new(user: current_user, friend: friend).valid?
      current_user.add_as_friend! friend
      flash[:sucess] = "You are now friends with #{friend.username}."
    else
      flash[:danger] = "There was a problem."
    end
    redirect_to friend
  end
  
  def destroy
    @user.unfriend! @friend
    flash[:danger] = "You have unfriended #{@friend.username}."
    redirect_to @friend
  end
  
  private
    
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
