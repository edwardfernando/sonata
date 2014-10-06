class Schedule < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: [:update, :destroy, :create], owner: Proc.new{ |controller, model| controller.current_person },
    :params => {
      :model_details => proc {|controller, model_instance| model_instance.to_json},
      :role_name => proc {|controller, model_instance| model_instance.role.name},
      :service_name => proc {|controller, model_instance| model_instance.service.name}
    }

  belongs_to :service
  belongs_to :person, :class_name => 'Person'
  belongs_to :created_by, :class_name => 'Person', :foreign_key => 'created_by'
  belongs_to :role

  validates :service, presence: true
  validates :person, presence: true
  validates :role, presence: true

end
