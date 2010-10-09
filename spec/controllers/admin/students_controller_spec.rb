require 'spec_helper'

describe Admin::StudentsController do
  before(:each) do
    controller.stub!(:require_admin!)
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
  
  describe "handling GET to new" do
    before(:each) do
      @student = Factory.build(:user)
      User.stub!(:new).and_return(@student)
    end
    
    def do_get
      get :new
    end
    
    it "should instantiate a new student object" do
      User.should_receive(:new_with_phone_numbers).and_return(@student)
      do_get
      assigns(:student).should == @student
    end
  
    it "should render the new template" do
      do_get
      response.should render_template "new"
    end
  end
  
  describe "handling POST to create" do
    before(:each) do
      @student = Factory.build(:user)
      User.stub!(:new).and_return(@student)
    end
    
    def do_post
      post :create, :user => @student.attributes
    end
    
    it "should instanitate a new student object" do
      User.should_receive(:new).with(@student.attributes).and_return(@student)
      do_post
      assigns(:student).should == @student
    end
    
    context "when the student object successfully saves" do
      before(:each) do
        @student.stub!(:save).and_return(true)
      end
      
      it "should set the flash message" do
        do_post
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to /admin/students" do
        do_post
        response.should redirect_to admin_students_path
      end
    end
    
    context "when the student object fails to save" do
      before(:each) do
        @student.stub!(:save).and_return(false)
      end
      
      it "should render the new action" do
        do_post
        response.should render_template "new"
      end
    end
  end
  
  describe "handling GET to show" do
    before(:each) do
      @student = Factory(:user)
      User.stub!(:find).and_return(@student)
    end
    
    def do_get
      get :show, :id => @student.id
    end
    
    it "should find the requested student object" do
      User.should_receive(:find).with(@student.id).and_return(@student)
      do_get
      assigns(:student).should == @student
    end
    
    it "should render the show template" do
      do_get
      response.should render_template "show"
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
      
      it "should redirect to /admin/students/1" do
        do_post
        response.should redirect_to admin_student_path(@student)
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
  
  describe "handling POST to destroy" do
    before(:each) do
      @student = Factory(:user)
      User.stub!(:find).and_return(@student)
    end
    
    def do_post
      post :destroy, :id => @student.id
    end
    
    it "should reduce the total number of students by -1" do
      proc { do_post }.should change(User, :count).by(-1)
    end
  
    it "should set the flash message" do
      do_post
      flash[:notice].should_not be_nil
    end
    
    it "should redirect to /admin/students" do
      do_post
      response.should redirect_to admin_students_path
    end
  end
  
  describe "handling GET to transition" do
    before(:each) do
      @student = Factory(:user)
      User.stub!(:find).and_return(@student)
    end
    
    def do_get
      get :transition, :id => @student.id, :transition => 'suspended', :format => :js
    end
    
    it "should find the requested student object" do
      User.should_receive(:find).with(@student.id).and_return(@student)
      do_get
      assigns(:student).should == @student
    end
    
    it "should update the student's transition" do
      @student.should_receive(:update_attribute).with(:state, 'suspended')
      do_get
    end

    context "when the student successfully updates" do
      before(:each) do
        @student.stub!(:update_attribute).and_return(true)
      end
      
      it "should set the flash message" do
        do_get
        flash[:notice].should_not be_nil
      end
      
      it "should render the transition template" do
        do_get
        response.should render_template "transition"
      end
    end
  end
end