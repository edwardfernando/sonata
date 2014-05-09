class AddAdditionalInformationToService < ActiveRecord::Migration
  def change
    add_column :services, :date, :date
  end
end
