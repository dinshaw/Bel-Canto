class CmsPage < ActiveRecord::Base
  acts_as_list
  attr_accessible :key, :css_class, :title, :sub_title, :nav_text, :body, :meta_keywords, :meta_description, :position, :parent_id

  validates :key, :presence => true
  validates :title, :presence => true

  default_scope order('key')

  def self.get(key)
    find_by_key(key) || self.new(:title => key, :sub_title => ':: Missing CMS Page ::')
  end

  def is_current?(uri)
    self.path.blank? ? false : uri.match(self.path)
  end

end
