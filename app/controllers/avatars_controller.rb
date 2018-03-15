class AvatarsController < ApplicationController
  
  before_action :authenticate_user!   
    
  def show
    
  end
  
  def update
    local_upload || remote_upload
    if current_user.save
      flash[:success] = "Your avatar has been updated."
    else
      flash[:danger] = "Something went wrong."
    end
    
    redirect_to avatar_path
  end
  
  private
  
  def local_upload
    avatar = params[:avatar] && params[:avatar][:local]
    return if avatar.nil?
    current_user.avatar = avatar
  end
  
  def remote_upload
    avatar = params[:avatar] && params[:avatar][:remote]
    return if avatar.nil?
    current_user.remote_avatar_url = avatar
  end
end
