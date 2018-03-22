class LikesController < ApplicationController
    
  before_action :authenticate_user!
  before_action :validate_type
  before_action :load_object
  
  def like
    like = Like.new(like_params)
    like.liker = current_user
    respond_to do |format|
      format.html { 
        unless like.save
          flash[:danger] = "There was a problem."
          redirect_to root_url
        else
          flash[:success] = "You liked the #{@type.downcase}." 
          redirect_to @post
        end
      }
      format.js {
        like.save
        render action: "#{@type.downcase}s_toggleable"
      }
    end
  end
  
  def unlike
    Like.where(like_params).first.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = "You unliked the #{@type.downcase}."
        redirect_to @post
      }
      format.js  { render action: "#{@type.downcase}s_toggleable" }
    end
  end
  
  private
  
    def like_params
      params.permit(:likeable_id, :likeable_type)
    end
    
    def validate_type
      @type = params[:likeable_type]
      redirect_to root_url if ["Post", "Comment"].exclude? @type
    end
    
    def load_object
      if @type == "Post"
        @post = Post.find(params[:likeable_id])
      elsif @type == "Comment"
        @comment = Comment.find(params[:likeable_id])
        @post = @comment.post
      end
    end
end
