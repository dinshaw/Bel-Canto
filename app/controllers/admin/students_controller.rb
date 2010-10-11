class Admin::StudentsController < Admin::BaseController
  before_filter :find_student, :only => [:show, :edit, :update, :destroy, :transition]
  
  def index
    @students = User.paginate :page => params[:page] || 1, :order => 'last_name asc, first_name asc'
  end
  
  def new
    @student = User.new_with_phone_numbers
  end
  
  def create
    @student = User.new(params[:user])

    if @student.save
      flash[:notice] = "The student was successfully created"
      redirect_to admin_students_path
    else
      render :action => "new"
    end
  end
  
  def update
    if @student.update_attributes(params[:user])
      flash[:notice] = "The student was successfully updated"
      redirect_to admin_student_path(@student)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    if @student.destroy
      flash[:notice] = "The student was successfully removed"
      redirect_to admin_students_path
    end
  end
  
  def transition
    @student.send([params[:transition],'!'].join)
  end

  private

  def find_student
    @student = User.find(params[:id])
  end
end