class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable #, :validatable


  has_many :websites, dependent: :destroy

  def self.find_by_auth(auth)
    return User.where(:provider => auth.provider, :uid => auth.uid).first
  end

  def self.create_from_facebook(auth)
    user = User.create(
                  name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            oauth_token:auth.credentials.token,
                            oauth_expires_at:Time.at(auth.credentials.expires_at),
                            avatar_url:auth.info.image,
                            random_id:Devise.friendly_token[0,20]
                          )
  end


  def self.create_from_twitter(auth)
     user = User.create(name:auth.info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:"",
          oauth_token:auth.credentials.token,
          avatar_url:auth.info.image,
          random_id:Devise.friendly_token[0,20],
        )

    user.save(validate: false)
    return user
  end

end
