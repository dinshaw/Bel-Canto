Rspec::Matchers.define :allow_access_to do |expected|
  match do |actual|
    actual.accessible_to?(expected) == true
  end
  
  failure_message_for_should do |actual|
    "expected that #{actual} would allow access to #{expected}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual} would not allow access to #{expected}"
  end
end