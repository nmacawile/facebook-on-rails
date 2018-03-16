class BannersController < ApplicationController
    
  before_action :authenticate_user!   
    
  def show
  end
  
  def update
    local_upload || remote_upload
    if current_user.save
      flash[:success] = "Your banner has been updated."
    else
      flash[:danger] = "Something went wrong."
    end
    
    redirect_to banner_path
  end
  
  private
  
  def local_upload
    banner = params[:banner] && params[:banner][:local]
    return if banner.nil?
    current_user.banner = banner
  end
  
  def remote_upload
    banner = params[:banner] && params[:banner][:remote]
    return if banner.nil?
    current_user.remote_banner_url = banner
  end
end
