class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def after_sign_in_path_for(person)
    if !person.is_approved?
      return profile_path
    else
      return root_path
    end
  end

  def facebook
    auth = env["omniauth.auth"]
    @person = Person.find_by_auth(auth)

    if @person.nil?
      @person = Person.create_from_facebook(auth)
    elsif(!@person.is_approved?)
      set_flash_message(:danger, :not_approved, :name => @person.name, :kind => "Facebook")
    else
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    end

    sign_in_and_redirect @person, :event => :authentication

  end

  def twitter
    auth = env["omniauth.auth"]
    @person = Person.find_by_auth(auth)

    if @person.nil?
      @person = Person.create_from_twitter(auth)
    elsif(!@person.is_approved?)
        set_flash_message(:danger, :not_approved, :name => @person.name, :kind => "Twitter")
    else
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    end

    sign_in_and_redirect @person, :event => :authentication

  end
end
