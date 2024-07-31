require "application_system_test_case"

class OdataRequestsTest < ApplicationSystemTestCase
  setup do
    @odata_request = odata_requests(:one)
  end

  test "visiting the index" do
    visit odata_requests_url
    assert_selector "h1", text: "Odata requests"
  end

  test "should create odata request" do
    visit odata_requests_url
    click_on "New odata request"

    fill_in "Authorization", with: @odata_request.authorization
    fill_in "Base url", with: @odata_request.base_url
    fill_in "Collection", with: @odata_request.collection_id
    fill_in "Description", with: @odata_request.description
    fill_in "Name", with: @odata_request.name
    fill_in "Url", with: @odata_request.url
    click_on "Create Odata request"

    assert_text "Odata request was successfully created"
    click_on "Back"
  end

  test "should update Odata request" do
    visit odata_request_url(@odata_request)
    click_on "Edit this odata request", match: :first

    fill_in "Authorization", with: @odata_request.authorization
    fill_in "Base url", with: @odata_request.base_url
    fill_in "Collection", with: @odata_request.collection_id
    fill_in "Description", with: @odata_request.description
    fill_in "Name", with: @odata_request.name
    fill_in "Url", with: @odata_request.url
    click_on "Update Odata request"

    assert_text "Odata request was successfully updated"
    click_on "Back"
  end

  test "should destroy Odata request" do
    visit odata_request_url(@odata_request)
    click_on "Destroy this odata request", match: :first

    assert_text "Odata request was successfully destroyed"
  end
end
