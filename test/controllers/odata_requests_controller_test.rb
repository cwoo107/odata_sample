require "test_helper"

class OdataRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @odata_request = odata_requests(:one)
  end

  test "should get index" do
    get odata_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_odata_request_url
    assert_response :success
  end

  test "should create odata_request" do
    assert_difference("OdataRequest.count") do
      post odata_requests_url, params: { odata_request: { authorization: @odata_request.authorization, base_url: @odata_request.base_url, collection_id: @odata_request.collection_id, description: @odata_request.description, name: @odata_request.name, url: @odata_request.url } }
    end

    assert_redirected_to odata_request_url(OdataRequest.last)
  end

  test "should show odata_request" do
    get odata_request_url(@odata_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_odata_request_url(@odata_request)
    assert_response :success
  end

  test "should update odata_request" do
    patch odata_request_url(@odata_request), params: { odata_request: { authorization: @odata_request.authorization, base_url: @odata_request.base_url, collection_id: @odata_request.collection_id, description: @odata_request.description, name: @odata_request.name, url: @odata_request.url } }
    assert_redirected_to odata_request_url(@odata_request)
  end

  test "should destroy odata_request" do
    assert_difference("OdataRequest.count", -1) do
      delete odata_request_url(@odata_request)
    end

    assert_redirected_to odata_requests_url
  end
end
