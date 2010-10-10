module ApplicationHelper
  def is?(coin)
    coin ? 'Yes' : 'No'
  end
  
  def admin?
    current_user && current_user.admin?
  end
  
  def editor?
    current_user && current_user.admin? || current_user.editor?
  end
end
