class Schedule < ActiveRecord::Base
  belongs_to :service
  belongs_to :person
  belongs_to :role
end
