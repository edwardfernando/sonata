class AddIsRejectedToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :is_rejected, :integer, :default => 0
    Schedule.update_all(:is_rejected => 0)
  end
end
