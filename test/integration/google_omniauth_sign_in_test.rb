require 'test_helper'

class GoogleOmniauthSignInTest < ActionDispatch::IntegrationTest
  def setup
    OmniAuth.config.test_mode = true
    @omniauth_hash = Faker::Omniauth.google
    OmniAuth.config.add_mock(:google_oauth2, @omniauth_hash)
  end
  
  def register_user
    user_info = @omniauth_hash[:info]
    User.create!(email: user_info[:email],
                 first_name: user_info[:first_name],
                 last_name: user_info[:last_name],
                 birthday: Date.parse("10/10/1980"),
                 gender: :male,
                 username: "test999",
                 password: "test12",
                 password_confirmation: "test12")
  end
  
  test "should sign user in and redirect to home page if already registered" do
    register_user
    get user_google_oauth2_omniauth_authorize_url
    follow_redirect!
    assert_redirected_to root_url
    follow_redirect!
    assert_match "test999", response.body
  end
  
  test "should redirect to sign up if not registered" do
    get user_google_oauth2_omniauth_authorize_url
    follow_redirect!
    assert_redirected_to new_user_registration_url
  end
end
