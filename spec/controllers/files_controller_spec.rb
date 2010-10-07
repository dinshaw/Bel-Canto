require 'spec_helper'

describe FilesController do
  before(:each) do
    controller.stub!(:authenticate_user!)
  end
  
  describe "handling GET to download" do
    before(:each) do
      @upload = Factory(:upload)
      Upload.stub!(:find_by_id).and_return(@upload)
      controller.stub!(:send_file)
      controller.stub!(:render)
    end
    
    def do_get
      get :download, :id => @upload.id
    end
    
    context "when the requested download does not exist" do
      before(:each) do
        Upload.stub!(:find_by_id).and_return(nil)
      end
      
      it "should set the flash" do
        do_get
        flash[:alert].should_not be_nil
      end
      
      it "should redirect to /files" do
        do_get
        response.should redirect_to files_path
      end
    end
    
    context "when the current user has permission to download the requested upload" do
      before(:each) do
        @upload.stub!(:accessible_to?).and_return(true)
      end
      
      it "should find the requested upload object" do
        Upload.should_receive(:find_by_id).with(@upload.id).and_return(@upload)
        do_get
      end
      
      it "should send the file" do
        # TODO: How to test send_file, as stubing it assumes a template is
        # to be rendered when there in fact isn't one.
        # controller.should_receive(:send_file)
        do_get
      end
    end
    
    context "when the current user does not have permission to download the requested upload" do
      before(:each) do
        @upload.stub!(:accessible_to?).and_return(false)
      end
      
      it "should set the flash" do
        do_get
        flash[:alert].should_not be_nil
      end
      
      it "should redirect to /files" do
        do_get
        response.should redirect_to files_path
      end
    end
  end
end