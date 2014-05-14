class Person < ActiveRecord::Base
  has_many :skillsets, :dependent => :destroy
  has_many :roles, :through => :skiilsets

  has_many :schedules, :dependent => :destroy
end
