module PeopleHelper

  def parse_avatar (person)

      if person.provider == "facebook"
        person.avatar_url.to_s + "?type=large"
      elsif person.provider == "twitter"
        person.avatar_url.to_s.gsub "_normal", ""
      else
        person.avatar_url = "default_avatar.png"
      end

  end

end
