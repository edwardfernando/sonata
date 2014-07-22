class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :service_id
      t.string :name
      t.string :url

      t.timestamps
    end

    add_index :attachments, :service_id
  end
end
