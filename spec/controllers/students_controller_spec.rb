require 'spec_helper'

describe StudentsController do
  before(:each) do
    controller.stub!(:authenticate_user!)
    controller.stub!(:validate_owner!)
  end
  
  describe "handling GET to index" do
    def do_get
      get :index
    end
  
    it "should get a paginated list of students and assign them to the view" do
      User.should_receive(:paginate).with(:page => 1, :order => 'last_name asc, first_name asc').and_return(@students)
      do_get
      assigns(:students).should == @students
    end
  
    it "should render the index template" do
      do_get
      response.should render_template "index"
    end
  end
  
  describe "handling GET to edit" do
    before(:each) do
      @student = Factory(:user)
      Upload.stub!(:find).and_return(@student)
    end
    
    def do_get
      get :edit, :id => @student.id
    end
    
    it "should find the requested student object" do
      User.should_receive(:find).with(@student.id).and_return(@student)
      do_get
      assigns(:student).should == @student
    end
    
    it "should render the edit template" do
      do_get
      response.should render_template "edit"
    end
  end


  describe "handling POST to update" do
    before(:each) do
      @student = Factory(:user)
      User.stub!(:find).and_return(@student)
    end
    
    def do_post
      post :update, :id => @student.id, :upload => @student.attributes
    end
    
    it "should find the requested student object" do
      User.should_receive(:find).with(@student.id).and_return(@student)
      do_post
      assigns(:student).should == @student
    end
    
    context "when the student object successfully updates" do
      before(:each) do
        @student.stub!(:update_attributes).and_return(true)
      end
      
      it "should set the flash message" do
        do_post
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to /students" do
        do_post
        response.should redirect_to students_path
      end
    end
    
    context "when the student object fails to update" do
      before(:each) do
        @student.stub!(:update_attributes).and_return(false)
      end
      
      it "should render the edit action" do
        do_post
        response.should render_template "edit"
      end
    end
  end
end