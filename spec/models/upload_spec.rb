require 'spec_helper'

describe Upload do
  it { should validate_presence_of(:label) }
  it { should have_attached_file(:file) }
  it { should validate_attachment_presence(:file) }
  
  it "should represent itself in the url as id-label" do
    upload = Factory(:upload, :id => 1, :label => 'File 1')
    upload.to_param.should == '1-file-1'
  end
  
  describe "knowing who to grant access to for download" do
    before(:each) do
      @upload = Factory(:upload, :access_mask => 68) # advanced
      @joe = Factory(:user); @jane = Factory(:user)
    end
    
    it "should grant access by user state" do
      trial_student    = Factory(:user, :state => "trial")
      advanced_student = Factory(:user, :state => "advanced")
      @upload.should_not allow_access_to trial_student
      @upload.should allow_access_to advanced_student
    end
    
    it "should grant access by individual student" do
      @upload.users << @joe
      @upload.should_not allow_access_to @jane
      @upload.should allow_access_to @joe
    end
  end
end
