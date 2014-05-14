class Role < ActiveRecord::Base
  has_many :skillsets
  has_many :people, :through => :skiilsets

  has_many :schedules, :dependent => :destroy
end
