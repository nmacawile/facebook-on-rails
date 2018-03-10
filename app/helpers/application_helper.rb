module ApplicationHelper
    
  def use_google_data
    google_data = session['devise.google_data'] && session['devise.google_data']['info']
    if google_data
      session.delete('devise.google_data')
      @user = User.new(email: google_data['email'],
                       first_name: google_data['first_name'],
                       last_name: google_data['last_name'])
    else
      @user = User.new
    end
  end
  
  def bootstrap_status_class(status)
    status_hash = { "notice" => "info", "alert" => "danger" }
    status_hash[status].nil? ? status : status_hash[status]
  end
end
