class UsersController < ApplicationController
  
  before_action :load_user, only: [:show, :friends]
  before_action :load_friendship_or_friend_request, only: :show
  
  def show
    @post = Post.new
  end
  
  def index
    @results = User.search(params[:q])
  end
  
  def friends
    @friends = @user.friends
  end
  
  private
  
    def load_user
      @user = User.find_by_username(params[:username])
    end
    
    def load_friendship_or_friend_request
      if user_signed_in?
        if current_user.friends_with?(@user)
          @friendship = Friendship.between(current_user, @user)
        elsif FriendRequest.exists?(user: current_user, friend: @user)
          @friend_request_out = FriendRequest.fetch(current_user, @user)
        elsif FriendRequest.exists?(user: @user, friend: current_user)
          @friend_request_in = FriendRequest.fetch(@user, current_user)
        end          
      end
    end
end
