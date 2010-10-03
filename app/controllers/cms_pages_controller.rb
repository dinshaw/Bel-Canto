class CmsPagesController < ApplicationController
  def index
    @cms_pages = CmsPage.all
  end
  
  def show
    @cms_page = CmsPage.find(params[:id])
  end
  
  def new
    @cms_page = CmsPage.new
  end
  
  def create
    @cms_page = CmsPage.new(params[:cms_page])
    if @cms_page.save
      flash[:notice] = "Successfully created cms page."
      redirect_to @cms_page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cms_page = CmsPage.find(params[:id])
  end
  
  def update
    @cms_page = CmsPage.find(params[:id])
    if @cms_page.update_attributes(params[:cms_page])
      flash[:notice] = "Successfully updated cms page."
      redirect_to @cms_page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cms_page = CmsPage.find(params[:id])
    @cms_page.destroy
    flash[:notice] = "Successfully destroyed cms page."
    redirect_to cms_pages_url
  end
end