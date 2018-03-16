class UsersController < ApplicationController
  
  before_action :load_user, only: [:show, :friends, :avatar]
  
  def show
    @posts = @user.posts
  end
  
  def index
    @results = User.search(params[:q])
  end
  
  def friends
    @friends = @user.friends
    
    if @user == current_user
      @friends_to_confirm = current_user.friends_to_confirm
      @friends_pending = current_user.friends_pending
    end
    
  end
  
  def avatar
  end
  
  private
  
    def load_user
      @user = User.find_by_username(params[:username])
    end
end
