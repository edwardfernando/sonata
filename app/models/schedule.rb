class Schedule < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :service
  belongs_to :person
  belongs_to :role

  validates :service, presence: true
  validates :person, presence: true
  validates :role, presence: true

end
