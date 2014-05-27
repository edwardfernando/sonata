class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    auth = env["omniauth.auth"]
    @user = User.find_by_auth(auth)

    if @user.nil?
      @user = User.create_from_facebook(auth)
      set_flash_message(:notice, :not_approved, :name => @user.name, :kind => "Facebook")
      redirect_to root_path
    elsif(!@user.is_approved?)
      set_flash_message(:notice, :not_approved, :name => @user.name, :kind => "Facebook")
      redirect_to root_path
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
      set_flash_message(:notice, :not_approved, :name => @user.name, :kind => "Twitter")
      redirect_to root_path
    elsif(!@user.is_approved?)
        set_flash_message(:notice, :not_approved, :name => @user.name, :kind => "Twitter")
        redirect_to root_path
    else
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication
    end

  end
end
