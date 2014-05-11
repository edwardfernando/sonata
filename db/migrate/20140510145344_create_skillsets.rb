class CreateSkillsets < ActiveRecord::Migration
  def change
    create_table :skillsets do |t|
      t.integer :person_id
      t.integer :role_id
      t.timestamps
    end

    add_index :skillsets, :person_id
    add_index :skillsets, :role_id
    add_index :skillsets, [:person_id, :role_id], :unique => true
  end
end
