class ChangeSchedulesStructure < ActiveRecord::Migration
  change_table :schedules do |t|
    t.remove :is_confirmed, :is_rejected, :confirmed_at
    t.integer :status
    t.datetime :status_date
  end
end
