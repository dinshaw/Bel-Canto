class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :admin, :editor, :state
end
