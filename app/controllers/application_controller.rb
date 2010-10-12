class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_cms_page

  autocomplete :user, :first_name

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to students_url
  end

  def get_cms_page
    controller = self.controller_name.titleize
    # Admin user should not need to differentiate between edit / update and new / create
    action = case self.action_name
    when "create"
      "New"
    when "update"
      "Edit"
    else
      self.action_name.titleize
    end
    @cms_page = CmsPage.get([controller,action].join(": "))
  end
end
