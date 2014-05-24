class SessionsController < Devise::OmniauthCallbacksController

  def login
  end

  def destroy
  	reset_session
  	flash[:success] = "Log out succeffully"
  	redirect_to root_path
  end

  def facebook
    auth = env["omniauth.auth"]
    @user = User.find_by_auth(auth)

    if @user.nil?
      @user = User.create_from_facebook(auth)
      redirect_to init_profile_path(@user.random_id)
    elsif !@user.profile_is_complete
      redirect_to init_profile_path(@user.random_id)
    else
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication
    end
  end

  def twitter
    auth = env["omniauth.auth"]
    @user = User.find_by_auth(auth)

    if @user.nil?
      @user = User.create_from_twitter(auth)
      redirect_to init_profile_path(@user.random_id)
    elsif !@user.profile_is_complete
      redirect_to init_profile_path(@user.random_id)
    else
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication
    end
  end
end
