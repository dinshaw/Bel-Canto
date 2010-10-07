class Admin::BaseController < ApplicationController
  before_filter :require_admin!
  
  def index; end
  
  
  private
  
  def require_admin!
    unless current_user and current_user.admin
      flash[:alert] = 'You are not authorized to view the requested page.'
      redirect_to root_path
    end
  end
end