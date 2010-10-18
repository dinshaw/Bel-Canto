class PrivateLesson < ActiveRecord::Base
  attr_accessible :user_id, :start_time, :end_time
  belongs_to :student, :class_name => 'User', :foreign_key => 'user_id'
    
  def to_json
    {
      :id => id,
      :start => start_time,
      :end => end_time,
      :title => student.try(:full_name)
    }.to_json
  end
end
