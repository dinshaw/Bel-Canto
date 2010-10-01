class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :admin
      t.boolean :editor
      t.string :state
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
