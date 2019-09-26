require 'test_helper'

class RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate = rates(:one)
  end

  test "should show rate" do
    get root_path
    assert_response :success
  end

  test "should get edit" do
    get admin_path
    assert_response :success
  end

  test "should update rate" do
    patch admin_path, params: { rate: { rate: "25.1790", overwrite: Time.now.to_s } }
    assert_redirected_to root_path
  end

end
