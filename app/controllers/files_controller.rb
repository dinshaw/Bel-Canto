class FilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_upload!, :only => [:download]
  before_filter :validate_access!, :only => [:download]
  
  def index
    @uploads = Upload.all
  end
  
  def download
    # TODO: This will eventually need to include Apache/Ngnix mods
    # so we don't bottleneck.  Might not be necessary for this app.
    send_file @upload.file.path, :type => @upload.file_content_type
  end
  
  
  private
  
  def find_upload!
    unless @upload = Upload.find_by_id(params[:id])
      flash[:alert] = "The requested download could not be found"
      redirect_to files_path
    end
  end
  
  def validate_access!
    unless @upload.accessible_to?(current_user)
      flash[:alert] = "You do not have permission to download this file"
      redirect_to files_path
    end
  end
end
