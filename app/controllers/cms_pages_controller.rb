class CmsPagesController < ApplicationController
  load_and_authorize_resource
  skip_filter :get_cms_page
  before_filter :set_title
  
  def create
    if @cms_page.save
      flash[:notice] = "Successfully created cms page."
      redirect_to @cms_page
    else
      render :action => 'new'
    end
  end
    
  def update
    if @cms_page.update_attributes(params[:cms_page])
      flash[:notice] = "Successfully updated cms page."
      redirect_to @cms_page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cms_page.destroy
    flash[:notice] = "Successfully destroyed cms page."
    redirect_to cms_pages_url
  end

  private
  def set_title
    @title = 'CMS Pages'
  end
end
