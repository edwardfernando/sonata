class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def is_profile_complete(person)
    if person.email.blank?
      return false
    elsif person.phone_number_1.blank?
      return false
    end

    return true
  end

  def after_sign_in_path_for(person)
    if !is_profile_complete(person)
      return profile_edit_path
    else
      return root_path
    end

  end

  def facebook
    auth = env["omniauth.auth"]
    @person = Person.find_by_auth(auth)

    if @person.nil?
      @person = Person.create_from_facebook(auth)
    elsif !is_profile_complete(@person)
      set_flash_message(:danger, :profile_not_compelte, :kind => "Facebook")
    elsif !@person.is_approved?
      set_flash_message(:danger, :not_approved, :name => @person.name, :kind => "Facebook")
    else
      set_flash_message(:info, :success, :kind => "Facebook") if is_navigational_format?
    end

    sign_in_and_redirect @person, :event => :authentication

  end

  def twitter
    auth = env["omniauth.auth"]
    @person = Person.find_by_auth(auth)

    if @person.nil?
      @person = Person.create_from_twitter(auth)
    elsif !is_profile_complete(@person)
        set_flash_message(:danger, :profile_not_compelte, :kind => "Twitter")
    elsif !@person.is_approved?
        set_flash_message(:danger, :not_approved, :name => @person.name, :kind => "Twitter")
    else
      set_flash_message(:info, :success, :kind => "Twitter") if is_navigational_format?
    end

    sign_in_and_redirect @person, :event => :authentication

  end
end
