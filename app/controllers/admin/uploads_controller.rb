class Admin::UploadsController < Admin::BaseController
  before_filter :find_upload, :only => [:show, :edit, :update, :destroy]
  
  def index
    @uploads = Upload.all
  end

  def new
    @upload = Upload.new
  end
  
  def create
    @upload = Upload.new(params[:upload])

    if @upload.save
      flash[:notice] = "Your file upload was successful"
      redirect_to admin_uploads_path
    else
      # Note: Temporary flash until thoughtbot fixes the error message placement for
      # validates_attachment_presence (http://github.com/thoughtbot/paperclip/issues/issue/266)
      flash[:alert] = "You must select a file to upload" if params[:upload][:file].blank?
      render :action => "new"
    end
  end
  
  def update
    if @upload.update_attributes(params[:upload])
      flash[:notice] = "Your file upload was successfully updated"
      redirect_to admin_upload_path(@upload)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    if @upload.destroy
      flash[:notice] = "Your file upload was successfully removed"
      redirect_to admin_uploads_path
    end
  end
    
  
  private
  
  def find_upload
    @upload = Upload.find(params[:id])
  end
end
