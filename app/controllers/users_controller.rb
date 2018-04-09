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
  
  def edit
  end
  
  def update
    @user = current_user
    if @user.update_attributes(user_profile_params)
      flash[:success] = "Your profile has been updated."
      redirect_to edit_profile_path
    else
      flash.now[:danger] = "There was a problem."
      render 'edit'
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
    
    def user_profile_params
      params.require(:user).permit(:first_name, :last_name, :birthday, :gender)
    end
end
