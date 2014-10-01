module PeopleHelper

  def parse_avatar (person)
    if person.provider == "facebook"
      person.avatar_url + "?type=large"
    elsif person.provider == "twitter"
      person.avatar_url.gsub "_normal", ""
    else
      person.avatar_url = "default_avatar.png"
    end
  end

end
