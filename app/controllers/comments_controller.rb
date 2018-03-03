class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: :create
  before_action :load_comment, only: [:edit, :update, :destroy]
  before_action :load_page_owner, only: [:edit, :update, :destroy]
  before_action :commenter_or_page_owner_only, only: :destroy
  before_action :commenter_only, only: [:edit, :update]
  
  def edit
  end
    
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created."
    else
      flash[:danger] = "Failed to create a comment."
    end
    redirect_to @post.user
  end
  
  def update
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated."
    else
      flash[:danger] = "Comment not updated."
    end
    redirect_to @page_owner
  end
  
  def destroy
    @comment.destroy
    flash[:notice] = "The comment has been deleted."
    redirect_to @page_owner
  end
  
  private
    
    def comment_params
      params.require(:comment).permit(:body)
    end
    
    def load_post
      @post = Post.find(params[:post_id])
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
    
    def redirect_to_owner
      flash[:danger] = "You are not authorized to do that."
      redirect_to @page_owner
    end
end
