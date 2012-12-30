require 'test_helper'

class WritingsControllerTest < ActionController::TestCase
  setup do
    @writing = writings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:writings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create writing" do
    assert_difference('Writing.count') do
      post :create, writing: { author_id: @writing.author_id, body: @writing.body, friends_r: @writing.friends_r, global_r: @writing.global_r, title: @writing.title }
    end

    assert_redirected_to writing_path(assigns(:writing))
  end

  test "should show writing" do
    get :show, id: @writing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @writing
    assert_response :success
  end

  test "should update writing" do
    put :update, id: @writing, writing: { author_id: @writing.author_id, body: @writing.body, friends_r: @writing.friends_r, global_r: @writing.global_r, title: @writing.title }
    assert_redirected_to writing_path(assigns(:writing))
  end

  test "should destroy writing" do
    assert_difference('Writing.count', -1) do
      delete :destroy, id: @writing
    end

    assert_redirected_to writings_path
  end
end
