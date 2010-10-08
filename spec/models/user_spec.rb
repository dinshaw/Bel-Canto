require 'spec_helper'

describe User do
  it "should know its states via state_machine" do
    User.states.should_not be_nil # TODO: Find a better way to test this
  end
  
  it "should know how to build a user with phone numbers" do
    user = User.new_with_phone_numbers
    user.phone_numbers.size.should == 2
  end
  
  it "should set the password and password confirmation to a random string" do
    user = Factory(:user, :password => '', :password_confirmation => '')
    user.password.should_not be_nil
    user.password_confirmation.should_not be_nil
  end
  
  it "should know its display name" do
    user = Factory(:user, :first_name => 'Joe', :last_name => 'Student')
    user.reverse_name.should == 'Student, Joe'
  end
end
