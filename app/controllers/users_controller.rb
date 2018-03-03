class UsersController < ApplicationController
  
  before_action :load_user, only: :show
  
  def show
    @post = Post.new
  end
  
  private
  
    def load_user
      @user = User.find_by(username: params[:username])
    end
end
