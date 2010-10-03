require 'test_helper'

class PrivateLessonsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => PrivateLesson.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PrivateLesson.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    PrivateLesson.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to private_lesson_url(assigns(:private_lesson))
  end
  
  def test_edit
    get :edit, :id => PrivateLesson.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PrivateLesson.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PrivateLesson.first
    assert_template 'edit'
  end

  def test_update_valid
    PrivateLesson.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PrivateLesson.first
    assert_redirected_to private_lesson_url(assigns(:private_lesson))
  end
  
  def test_destroy
    private_lesson = PrivateLesson.first
    delete :destroy, :id => private_lesson
    assert_redirected_to private_lessons_url
    assert !PrivateLesson.exists?(private_lesson.id)
  end
end
