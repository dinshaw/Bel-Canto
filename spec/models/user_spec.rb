require 'spec_helper'

describe User do
  it "should know its states via state_machine" do
    User.states.should_not be_nil # TODO: Find a better way to test this
  end
end
