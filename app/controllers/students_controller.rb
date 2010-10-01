class StudentsController < ApplicationController
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
  
  def edit
    @student = User.find(params[:id])
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
  
private
  def with_default_password(params)
    passwd = ActiveSupport::SecureRandom.base64(8)
    params.merge(:password => passwd,:confirm_password => passwd)
  end
end
