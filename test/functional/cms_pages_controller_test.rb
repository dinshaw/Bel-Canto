require 'test_helper'

class CmsPagesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => CmsPage.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CmsPage.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CmsPage.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to cms_page_url(assigns(:cms_page))
  end
  
  def test_edit
    get :edit, :id => CmsPage.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    CmsPage.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CmsPage.first
    assert_template 'edit'
  end

  def test_update_valid
    CmsPage.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CmsPage.first
    assert_redirected_to cms_page_url(assigns(:cms_page))
  end
  
  def test_destroy
    cms_page = CmsPage.first
    delete :destroy, :id => cms_page
    assert_redirected_to cms_pages_url
    assert !CmsPage.exists?(cms_page.id)
  end
end
