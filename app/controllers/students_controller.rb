class StudentsController < ApplicationController
  before_filter :find_student, :only => [ :edit, :update, :transition]
  
  def create
    @student = User.new(with_default_password(params[:user]))
    if @student.save
      flash[:notice] = "Successfully created student."
      redirect_to students_url
    else
      build_phone_numbers
      render :action => 'new'
    end
  end

  def edit
    build_phone_numbers
  end
  
  def index
    @students = User.all
  end
  
  def new
    @student = User.new
    build_phone_numbers
  end
  
  def transition
    @student.send([params[:transtion_to],'!'].join.to_sym)
    redirect_to request.referrer
  end
  
  def update
    if @student.update_attributes(params[:user])
      flash[:notice] = "Successfully updated student."
      redirect_to students_url
    else
      build_phone_numbers
      render :action => 'edit'
    end
  end
    
private

  def build_phone_numbers
    count = @student.phone_numbers.count
    count > 0 ? @student.phone_numbers.build :
      2.times { @student.phone_numbers.build }
  end
  def find_student
    @student = User.find(params[:id])
  end
  
  def with_default_password(params)
    passwd = ActiveSupport::SecureRandom.base64(8)
    params.merge(:password => passwd,:confirm_password => passwd)
  end
  
end
