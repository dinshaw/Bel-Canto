class PrivateLessonsController < ApplicationController
  respond_to :html, :json, :js
  
  def index
    @private_lessons = PrivateLesson.all
    respond_with(@private_lessons) do |format|
      format.js { render :json => @private_lessons.map(&:to_json) }
    end
  end
  
  def new
    @private_lesson = PrivateLesson.new
  end
  
  def create
    @private_lesson = PrivateLesson.new(params[:private_lesson])
    flash[:notice] = "User successfully created" if @private_lesson.save
    respond_with(@private_lesson)
  end
  
  def edit
    @private_lesson = PrivateLesson.find(params[:id])
  end
  
  def update
    @private_lesson = PrivateLesson.find(params[:id])
    if @private_lesson.update_attributes(params[:private_lesson])
      flash[:notice] = "Successfully updated private lesson."
      redirect_to private_lessons_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @private_lesson = PrivateLesson.find(params[:id])
    @private_lesson.destroy
    flash[:notice] = "Successfully destroyed private lesson."
    redirect_to private_lessons_url
  end
end
