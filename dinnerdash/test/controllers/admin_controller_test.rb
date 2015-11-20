require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get add_items" do
    get :add_items
    assert_response :success
  end

  test "should get remove_items" do
    get :remove_items
    assert_response :success
  end

  test "should get manage_users" do
    get :manage_users
    assert_response :success
  end

end
