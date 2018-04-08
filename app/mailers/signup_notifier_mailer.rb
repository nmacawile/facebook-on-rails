class SignupNotifierMailer < ApplicationMailer
  default :from => 'no-reply@fb-on-rails.herokuapp.com'

  def send_signup_email(user)
    @user = user
    mail to: @user.email,
         subject: 'Welcome to FB on Rails!'
  end
end
