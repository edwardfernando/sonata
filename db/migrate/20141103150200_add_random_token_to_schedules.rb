class AddRandomTokenToSchedules < ActiveRecord::Migration
  def self.up
    add_column :schedules, :random_id, :string

    Schedule.all.each do |a|
      # Set random_id for existing Schedules
      a.update(:random_id => SecureRandom.urlsafe_base64(50))
    end

  end
end
