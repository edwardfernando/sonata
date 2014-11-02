class ChangeServiceStructure < ActiveRecord::Migration
  def change
    change_column :services, :date, :datetime
  end
end
