require "test_helper"

class FilterGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filter_group = filter_groups(:one)
  end

  test "should get index" do
    get filter_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_filter_group_url
    assert_response :success
  end

  test "should create filter_group" do
    assert_difference("FilterGroup.count") do
      post filter_groups_url, params: { filter_group: { odata_request_id: @filter_group.odata_request_id } }
    end

    assert_redirected_to filter_group_url(FilterGroup.last)
  end

  test "should show filter_group" do
    get filter_group_url(@filter_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_filter_group_url(@filter_group)
    assert_response :success
  end

  test "should update filter_group" do
    patch filter_group_url(@filter_group), params: { filter_group: { odata_request_id: @filter_group.odata_request_id } }
    assert_redirected_to filter_group_url(@filter_group)
  end

  test "should destroy filter_group" do
    assert_difference("FilterGroup.count", -1) do
      delete filter_group_url(@filter_group)
    end

    assert_redirected_to filter_groups_url
  end
end
