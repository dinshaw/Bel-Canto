require 'test_helper'

class Key:stringsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Key:string.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Key:string.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Key:string.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to key:string_url(assigns(:key:string))
  end
  
  def test_edit
    get :edit, :id => Key:string.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Key:string.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Key:string.first
    assert_template 'edit'
  end

  def test_update_valid
    Key:string.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Key:string.first
    assert_redirected_to key:string_url(assigns(:key:string))
  end
  
  def test_destroy
    key:string = Key:string.first
    delete :destroy, :id => key:string
    assert_redirected_to key:strings_url
    assert !Key:string.exists?(key:string.id)
  end
end
