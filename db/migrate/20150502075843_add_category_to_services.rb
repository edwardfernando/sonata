class AddCategoryToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :category, :integer


    Service.all.each do |s|
      s.update(:category => "general")
    end
  end
end
