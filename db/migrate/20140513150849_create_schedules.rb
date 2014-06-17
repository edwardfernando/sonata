class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :service_id
      t.integer :person_id
      t.integer :role_id
      t.integer  :is_confirmed, default: 0
      t.datetime :confirmed_at
      t.string :reasons
      t.timestamps
    end

    add_index :schedules, :service_id
    add_index :schedules, :person_id
    add_index :schedules, :role_id
    add_index :schedules, [:service_id, :person_id, :role_id], :unique => true
  end
end
