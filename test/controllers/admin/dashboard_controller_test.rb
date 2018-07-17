require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers

  test "should get index" do
    sign_in Admin.find_by email: "admin1@example.com"
    get admin_dashboard_index_url
    assert_response :success
  end
end
