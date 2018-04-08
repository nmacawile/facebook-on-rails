class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :load_user, only: [:show, :friends, :avatar]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js { render "posts/posts"}
    end
  end
  
  def search
    @users = User.search(params[:q]).paginate(page: params[:page], per_page: 10)
  end
  
  def friends
    @users = @user.friends.paginate(page: params[:page], per_page: 10)
    
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
