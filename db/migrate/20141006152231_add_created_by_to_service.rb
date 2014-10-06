class AddCreatedByToService < ActiveRecord::Migration
  def self.up
    add_column :services, :created_by, :integer
    Service.where(:created_by => 0).update_all(:created_by => 1);
  end
end
