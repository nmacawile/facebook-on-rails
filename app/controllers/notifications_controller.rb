class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_notification, only: [:show, :destroy]
  before_action :for_notification_owner_only, only: [:show, :destroy]
  
  def index
    @notifications = current_user.notifications.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @notification.destroy
    redirect_to @notification.linkable
  end
  
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.js
    end
  end
  
  private
  
    def load_notification
      @notification = Notification.find_by(id: params[:id])
      redirect_to notifications_path unless @notification
    end
    
    def for_notification_owner_only
      redirect_to notifications_path unless current_user == @notification.receipient
    end
end
