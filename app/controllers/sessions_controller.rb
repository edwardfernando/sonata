class SessionsController < Devise::OmniauthCallbacksController

  def facebook
    auth = env["omniauth.auth"]
    @user = User.find_by_auth(auth)

    if @user.nil?
      @user = User.create_from_facebook(auth)
      # redirect_to init_user_path(@user.random_id)
    else
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    end

    sign_in_and_redirect @user, :event => :authentication
  end

  def twitter
    auth = env["omniauth.auth"]
    @user = User.find_by_auth(auth)

    if @user.nil?
      @user = User.create_from_twitter(auth)
      # redirect_to init_user_path(@user.random_id)
    else
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    end

    sign_in_and_redirect @user, :event => :authentication
  end
end
