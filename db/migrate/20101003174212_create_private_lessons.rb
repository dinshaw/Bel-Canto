class CreatePrivateLessons < ActiveRecord::Migration
  def self.up
    create_table :private_lessons do |t|
      t.references :user
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end

  def self.down
    drop_table :private_lessons
  end
end
