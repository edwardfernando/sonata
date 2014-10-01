class AddConfirmableToDevise < ActiveRecord::Migration
   # Note: You can't use change, as User.update_all with fail in the down migration
  def self.up
    add_column :people, :confirmation_token, :string
    add_column :people, :confirmed_at, :datetime
    add_column :people, :confirmation_sent_at, :datetime
    # add_column :people, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :people, :confirmation_token, :unique => true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # people as confirmed, do the following
    Person.update_all(:confirmed_at => Time.now)
    # All existing user accounts should be able to log in after this.
  end

  def self.down
    remove_columns :people, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :people, :unconfirmed_email # Only if using reconfirmable
  end
end
