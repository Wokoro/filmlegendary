require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get films_about_url
    assert_response :success
  end

  test "should get index" do
    get films_index_url
    assert_response :success
  end

  test "should get about" do
    get films_about_url
    assert_response :success
  end

  test "should get contactUs" do
    get films_contactUs_url
    assert_response :success
  end

end
