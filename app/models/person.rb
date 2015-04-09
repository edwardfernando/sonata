require 'file_size_validator'

class Person < ActiveRecord::Base
  has_many :skillsets, :dependent => :destroy
  has_many :roles, :through => :skiilsets

  has_many :schedules, :dependent => :destroy, inverse_of: :person


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :invitable, :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :invitable, :omniauthable, :trackable, :database_authenticatable, :registerable, :validatable, :confirmable, :recoverable

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  # TEMPORARY COMMENTED DUE TO REGISTRATION ISSUE - WILL FIGURE IT OUT
  # validates :phone_number_1, numericality: { only_integer: true }, presence: true
  # validates :phone_number_2, numericality: { only_integer: true }, allow_blank: true

  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  mount_uploader :avatar_url, AvatarUploader
  validates :avatar_url,
    :presence => false,
    :file_size => {
      :maximum => 0.5.megabytes.to_i
    }

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
                            random_id:Devise.friendly_token[0,5],
                            birthday:Date.strptime(auth.extra.raw_info.birthday, "%m/%d/%Y")
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
          random_id:Devise.friendly_token[0,5]
        )

    person.save(validate: false)
    return person
  end

end
