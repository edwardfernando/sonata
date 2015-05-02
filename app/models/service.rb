class Service < ActiveRecord::Base

    include PublicActivity::Model
    tracked except: [:update], owner: Proc.new{ |controller, model| controller.current_person },
      :params => {
        :model_details => proc {|controller, model_instance| model_instance.to_json}
      }

    has_many :schedules, :dependent => :destroy, inverse_of: :service
    has_many :attachments, :dependent => :destroy, inverse_of: :service

    validates :name, presence: true
    validates :date, presence: true

    belongs_to :created_by, :class_name => 'Person', :foreign_key => 'created_by'

    enum category: [:general, :rehearsal, :special]
end
