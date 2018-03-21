class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :load_post, only: [:index, :create]
  before_action :page_owner_or_friend_only, only: :create
  before_action :load_comment, only: [:edit, :update, :destroy]
  before_action :load_page_owner, only: [:edit, :update, :destroy]
  before_action :commenter_or_page_owner_only, only: :destroy
  before_action :commenter_only, only: [:edit, :update]
  before_action :check_if_owner_or_still_friends, only: [:edit, :update]
  
  def index
    @comments = @post.comments
  end
  
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end
    
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html {
          flash[:success] = "Comment created."
          redirect_to @post.user
        }
        format.js
      end
    else
      flash[:danger] = "Failed to create a comment."
      redirect_to @post.user
    end
  end
  
  def update
    if @comment.update_attributes(comment_params)
      respond_to do |format|
        format.html {
          flash[:success] = "Comment updated."
          redirect_to @page_owner
        }
        format.js
      end
    else
      flash[:danger] = "Comment not updated."
      redirect_to @page_owner
    end
  end
  
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = "The comment has been deleted." 
        redirect_to @page_owner
      }
      format.js
    end
  end
  
  private
    
    def comment_params
      params.require(:comment).permit(:body)
    end
    
    def load_post
      @post = Post.find(params[:post_id])
      @page_owner = @post.user
    end
    
    def page_owner_or_friend_only
      unless @post.user == current_user || Friendship.exists?(user: current_user, friend: @page_owner)
        redirect_to_owner
      end
    end
    
    def load_comment
      @comment = Comment.find(params[:id])
    end
    
    def load_page_owner
      @page_owner = @comment.post.user
    end
    
    def commenter_or_page_owner_only
      redirect_to_owner unless current_user == @comment.user || current_user == @page_owner
    end
    
    def commenter_only
      redirect_to_owner unless current_user == @comment.user
    end
    
    def check_if_owner_or_still_friends
      unless current_user == @page_owner || Friendship.exists?(user: current_user, friend: @page_owner)
        redirect_to_owner
      end
    end
    
    def redirect_to_owner
      flash[:danger] = "You are not authorized to do that."
      redirect_to @page_owner
    end
end
