class StudentsController < ApplicationController
  before_filter :find_student, :only => [ :edit, :update, :promote, :demote]
  
  def index
    @students = User.all
  end
  
  def new
    @student = User.new
  end
  
  def create
    @student = User.new(with_default_password(params[:user]))
    if @student.save
      flash[:notice] = "Successfully created student."
      redirect_to students_url
    else
      render :action => 'new'
    end
  end
    
  def update
    @student = User.find(params[:id])
    if @student.update_attributes(params[:user])
      flash[:notice] = "Successfully updated student."
      redirect_to students_url
    else
      render :action => 'edit'
    end
  end
  
  def promote
    @student.promote!
    redirect_to students_url    
  end
  
  def demote
    @student.demote!    
    redirect_to students_url    
  end
  
private
  def with_default_password(params)
    passwd = ActiveSupport::SecureRandom.base64(8)
    params.merge(:password => passwd,:confirm_password => passwd)
  end

  def find_student
    @student = User.find(params[:id])
  end
end
