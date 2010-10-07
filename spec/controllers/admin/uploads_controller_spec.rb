require 'spec_helper'

describe Admin::UploadsController do
  before(:each) do
    controller.stub!(:require_admin!)
  end
    
  describe "handling GET to new" do
    before(:each) do
      @upload = Factory.build(:upload)
      Upload.stub!(:new).and_return(@upload)
    end
    
    def do_get
      get :new
    end
    
    it "should instantiate a new upload object" do
      Upload.should_receive(:new).and_return(@upload)
      do_get
      assigns(:upload).should == @upload
    end
  
    it "should render the new template" do
      do_get
      response.should render_template "new"
    end
  end
  
  describe "handling POST to create" do
    before(:each) do
      @upload = Factory.build(:upload)
      Upload.stub!(:new).and_return(@upload)
    end
    
    def do_post
      post :create, :upload => @upload.attributes
    end
    
    it "should instanitate a new upload object" do
      Upload.should_receive(:new).with(@upload.attributes).and_return(@upload)
      do_post
      assigns(:upload).should == @upload
    end
    
    context "when the upload object successfully saves" do
      before(:each) do
        @upload.stub!(:save).and_return(true)
      end
      
      it "should set the flash message" do
        do_post
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to /admin/uploads" do
        do_post
        response.should redirect_to admin_uploads_path
      end
    end
    
    context "when the upload object fails to save" do
      before(:each) do
        @upload.stub!(:save).and_return(false)
      end
      
      it "should render the new action" do
        do_post
        response.should render_template "new"
      end
    end
  end
  
  describe "handling GET to index" do
    def do_get
      get :index
    end
    
    it "should assign all uploads to the view" do
      Upload.should_receive(:all).and_return(@uploads)
      do_get
      assigns(:uploads).should == @uploads
    end
    
    it "should render the index template" do
      do_get
      response.should render_template "index"
    end
  end
  
  describe "handling GET to show" do
    before(:each) do
      @upload = Factory(:upload)
      Upload.stub!(:find).and_return(@upload)
    end
    
    def do_get
      get :show, :id => @upload.id
    end
    
    it "should find the requested upload object" do
      Upload.should_receive(:find).with(@upload.id).and_return(@upload)
      do_get
      assigns(:upload).should == @upload
    end
    
    it "should render the show template" do
      do_get
      response.should render_template "show"
    end
  end
  
  describe "handling GET to edit" do
    before(:each) do
      @upload = Factory(:upload)
      Upload.stub!(:find).and_return(@upload)
    end
    
    def do_get
      get :edit, :id => @upload.id
    end
    
    it "should find the requested upload object" do
      Upload.should_receive(:find).with(@upload.id).and_return(@upload)
      do_get
      assigns(:upload).should == @upload
    end
    
    it "should render the edit template" do
      do_get
      response.should render_template "edit"
    end
  end


  describe "handling POST to update" do
    before(:each) do
      @upload = Factory(:upload)
      Upload.stub!(:find).and_return(@upload)
    end
    
    def do_post
      post :update, :id => @upload.id, :upload => @upload.attributes
    end
    
    it "should find the requested upload object" do
      Upload.should_receive(:find).with(@upload.id).and_return(@upload)
      do_post
      assigns(:upload).should == @upload
    end
    
    context "when the upload object successfully updates" do
      before(:each) do
        @upload.stub!(:update_attributes).and_return(true)
      end
      
      it "should set the flash message" do
        do_post
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to /admin/upload/1" do
        do_post
        response.should redirect_to admin_upload_path(@upload)
      end
    end
    
    context "when the upload object fails to update" do
      before(:each) do
        @upload.stub!(:update_attributes).and_return(false)
      end
      
      it "should render the edit action" do
        do_post
        response.should render_template "edit"
      end
    end
  end
  
  describe "handling POST to destroy" do
    before(:each) do
      @upload = Factory(:upload)
      Upload.stub!(:find).and_return(@upload)
    end
    
    def do_post
      post :destroy, :id => @upload.id
    end
    
    it "should reduce the total number of uploads by -1" do
      proc { do_post }.should change(Upload, :count).by(-1)
    end
  
    it "should set the flash message" do
      do_post
      flash[:notice].should_not be_nil
    end
    
    it "should redirect to /admin/uploads" do
      do_post
      response.should redirect_to admin_uploads_path
    end
  end
end
