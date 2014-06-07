module ProfilesHelper

  def parse_avatar  
    if current_person.provider == "facebook"
      current_person.avatar_url + "?type=large"
    elsif current_person.provider == "twitter"
      current_person.avatar_url.gsub "_normal", ""
    end
  end

end
