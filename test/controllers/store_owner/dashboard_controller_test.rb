require "test_helper"

class StoreOwner::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_owner_dashboard_index_url
    assert_response :success
  end
end
