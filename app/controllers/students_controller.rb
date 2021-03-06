class StudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_student, :validate_owner!, :only => [:edit, :update]
  
  def index
    @students = User.paginate :page => params[:page] || 1, :order => 'last_name asc, first_name asc'
  end

  def edit
    @student.phone_numbers.build if @student.phone_numbers.size == 0
    @student.files.build if @student.files.size == 0
  end
  
  def update
    if @student.update_attributes(params[:user])
      flash[:notice] = "Your student record was successfully updated"
      redirect_to students_path
    else
      render :action => "edit"
    end
  end
  
private
  
  def find_student
    @student = User.find(params[:id])
  end
  
  def validate_owner!
    authorize! :update, @student
  end
end
