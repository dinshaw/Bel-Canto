class CreateUploadsUsersTable < ActiveRecord::Migration
  def self.up
    create_table :uploads_users, :id => false do |t|
      t.integer     :upload_id, :null => false
      t.integer     :user_id,   :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads_users
  end
end
