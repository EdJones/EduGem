require 'test_helper'

class AssessmentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Assessment.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Assessment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Assessment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to assessment_url(assigns(:assessment))
  end

  def test_edit
    get :edit, :id => Assessment.first
    assert_template 'edit'
  end

  def test_update_invalid
    Assessment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Assessment.first
    assert_template 'edit'
  end

  def test_update_valid
    Assessment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Assessment.first
    assert_redirected_to assessment_url(assigns(:assessment))
  end

  def test_destroy
    assessment = Assessment.first
    delete :destroy, :id => assessment
    assert_redirected_to assessments_url
    assert !Assessment.exists?(assessment.id)
  end
end
