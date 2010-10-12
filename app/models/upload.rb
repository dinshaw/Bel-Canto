class Upload < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  has_attached_file :file, :path => "#{Rails.root}/non-public/system/:attachment/:id/:style/:basename.:extension",
                           :url  => "/files/:to_param/download"

  validates :title, :presence => true
  validates_attachment_presence :file
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  def access=(access)
    self.access_mask = (access & User.states).map { |r| 2**User.states.index(r) }.sum
  end
  
  def access
    User.states.reject { |r| ((access_mask || 0) & 2**User.states.index(r)).zero? }
  end
  
  def accessible_to?(user)
    user.accessible_files.include?(self) || self.access.include?(user.state)
  end
end
