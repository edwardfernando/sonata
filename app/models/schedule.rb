class Schedule < ActiveRecord::Base
  belongs_to :service
  belongs_to :person
  belongs_to :role

  validates :service, presence: true
  validates :person, presence: true
  validates :role, presence: true

end
