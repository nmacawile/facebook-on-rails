class FriendRequestsController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :avoid_sending_to_self, only: :create
  before_action :load_requestee, only: :create
  before_action :check_if_already_friends, only: :create
  before_action :check_for_outgoing_friend_request, only: :create
  before_action :check_for_incoming_friend_request, only: :create
  before_action :friend_request_exists, only: :destroy
  before_action :load_request, only: :destroy
  
  def create
    friend_request = FriendRequest.new(user: current_user, friend: @requestee)
    if friend_request.save
      flash[:success] = "You have sent a friend request to #{@requestee.username}."
    else
      flash[:danger] = "There was a problem."
    end
    redirect_to @requestee
  end

  def destroy
    if current_user == @requestee
      @friend_request.destroy
  	  flash[:notice] = "You have rejected the friend request."
  	elsif current_user == @requester
      @friend_request.destroy
      flash[:notice] = "You have cancelled the friend request."
    else
      flash[:danger] = "You are not authorized to do that."
    end
    redirect_to @requestee
  end
  
  def received
    @users = current_user.friends_to_confirm.paginate(page: params[:page], per_page: 10)
  end
  
  def sent
    @users = current_user.friends_pending.paginate(page: params[:page], per_page: 10)
  end

  private  

    def avoid_sending_to_self
      if current_user.id == params[:id].to_i
      	flash[:danger] = "You cannot send a friend request to yourself."
        redirect_to current_user
      end
    end   

    def load_requestee
      @requestee = User.find(params[:id])
    end

    def check_if_already_friends
      if Friendship.exists?(user: current_user.id, friend: params[:id])
        flash[:danger] = "You are already friends."
      	redirect_to @requestee
      end
    end

    def check_for_outgoing_friend_request
      if FriendRequest.exists?(user_id: current_user.id, friend_id: @requestee.id)
        flash[:danger] = "You already have a pending request for #{@requestee.username}."
        redirect_to @requestee
      end
    end

    def check_for_incoming_friend_request
      if FriendRequest.exists?(friend_id: current_user.id, user_id: @requestee.id)
        make_friends(current_user, @requestee)
      end     
    end

    def friend_request_exists
      unless FriendRequest.exists?(id: params[:id]) || params[:id].nil?
        flash[:danger] = "Not a valid friend request link."
        redirect_to current_user
      end
    end

    def load_request
      @friend_request = FriendRequest.find(params[:id])
      @requester = @friend_request.user
      @requestee = @friend_request.friend
    end
end
