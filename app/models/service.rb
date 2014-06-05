class Service < ActiveRecord::Base
    has_many :schedules, :dependent => :destroy, inverse_of: :service

    validates :name, presence: true
    validates :date, presence: true
end
