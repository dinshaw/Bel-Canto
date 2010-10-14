module CmsPagesHelper
  def head_title
    ['Art of Bel Canto',@cms_page.try(:title)].join('::')
  end
  
  def meta_description
    @cms_page.try(:meta_description) || @cms_page.try(:title)
  end

  def meta_keywords
    @cms_page.try(:meta_keywords) || @cms_page.try(:title)
  end
  
  def page_title
    @title || @student.try(:full_name) || @cms_page.try(:title)
  end

  def page_sub_title
    @student ? nil : @cms_page.try(:sub_title)
  end

end

