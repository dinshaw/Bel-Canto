require 'spec_helper'

describe PhoneNumber do
  ['2223334444', ''].each {|v| it { should allow_value(v).for(:number) } }
  ['this', '234', '222-333-4444'].each {|v| it { should_not allow_value(v).for(:number) } }
end
