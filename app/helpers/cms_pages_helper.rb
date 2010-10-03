module CmsPagesHelper
  def head_title
    ['Art of Bel Canto',@cms_page.title].join('::')
  end
  
  def meta_description
    @cms_page.meta_description || @cms_page.title
  end

  def meta_keywords
    @cms_page.meta_keywords || @cms_page.title
  end
end

