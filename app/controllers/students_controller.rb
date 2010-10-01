class StudentsController < ApplicationController
  def index
    @students = User.all
  end
  
  def new
    @student = User.new
  end
  
  def create
    @student = User.new(params[:student])
    if @student.save
      flash[:notice] = "Successfully created student."
      redirect_to students_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @student = User.find(params[:id])
  end
  
  def update
    @student = User.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Successfully updated student."
      redirect_to students_url
    else
      render :action => 'edit'
    end
  end
end
