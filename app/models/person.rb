class Person < ActiveRecord::Base
  has_many :skillsets, :dependent => :destroy
  has_many :roles, :through => :skiilsets
end
