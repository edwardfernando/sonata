class AddCreatedByToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :created_by, :integer
    Schedule.where(:created_by => 0).update_all(:created_by => 1);
  end
end
