class PostsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :load_user, only: :create
  before_action :load_post, only: [:edit, :update, :destroy]
  before_action :author_or_page_owner_only, only: :destroy
  before_action :author_only, only: [:edit, :update]
  
  def edit
  end
    
  def create
    @post = @user.posts.build(post_params)
    @post.poster = current_user
    if @post.save
      flash[:success] = "Post created."
    else
      flash[:danger] = "Post creation failed."
    end
    redirect_to user_path(@user)
  end
  
  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated."
    else
      flash[:danger] = "Post not updated."
    end
    redirect_to user_path(@post.user)
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "The post has been deleted."
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
    
    def author_or_page_owner_only
      redirect_to_owner unless current_user == @post.poster || current_user == @post.user
    end
    
    def author_only
      redirect_to_owner unless current_user == @post.poster
    end
    
    def redirect_to_owner
      flash[:danger] = "You are not authorized to do that."
      redirect_to @post.user 
    end
end
