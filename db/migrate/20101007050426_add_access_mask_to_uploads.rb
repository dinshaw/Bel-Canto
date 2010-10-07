class AddAccessMaskToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :access_mask, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :uploads, :access_mask
  end
end
