class UsersController < ApplicationController
  
  before_action :load_user, only: :show
  
  def show
    @post = Post.new
  end
  
  def search
    @results = User.search(params[:q])
  end
  
  private
  
    def load_user
      @user = User.find_by_username(params[:username])
    end
end
