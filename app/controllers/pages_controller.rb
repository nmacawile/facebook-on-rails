class PagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
      ids = current_user.friends.pluck :id
      ids << current_user.id
      @posts = Post.where(poster_id: ids, user_id: ids).paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.js { render "posts/posts"}
      end
    end
  end
end
