class PostsController < ApplicationController
    
  before_action :load_user, only: :create
  before_action :load_post, only: [:edit, :update, :destroy]
  
  def edit
  end
    
  def create
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created."
      redirect_to user_path(@user)
    else
      render 'users/show'
    end
  end
  
  def update
    if @post.update_attributes(post_params)
         flash[:notice] = "Post updated."
      redirect_to user_path(@post.user)
    else
     # render 'users/show'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to user_path(@post.user)
  end
  
  private
    
    def post_params
      params.require(:post).permit(:body)
    end
    
    def load_user
      @user = User.find_by(username: params[:user_username])
    end
    
    def load_post
      @post = Post.find(params[:id])
    end
end
