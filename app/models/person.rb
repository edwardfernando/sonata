class Person < ActiveRecord::Base
  has_many :skillsets, :dependent => :destroy
  has_many :roles, :through => :skiilsets

  has_many :schedules, :dependent => :destroy, inverse_of: :person


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable #, :validatable

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.find_by_auth(auth)
    return Person.where(:provider => auth.provider, :uid => auth.uid).first
  end

  def self.create_from_facebook(auth)
    person = Person.create(
                  name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            oauth_token:auth.credentials.token,
                            oauth_expires_at:Time.at(auth.credentials.expires_at),
                            avatar_url:auth.info.image,
                            random_id:Devise.friendly_token[0,20]
                          )

                        return person
  end


  def self.create_from_twitter(auth)
     person = Person.new(name:auth.info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:"",
          oauth_token:auth.credentials.token,
          avatar_url:auth.info.image,
          random_id:Devise.friendly_token[0,20],
        )

    person.save(validate: false)
    return person
  end

end
