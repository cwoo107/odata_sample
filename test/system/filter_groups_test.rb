require "application_system_test_case"

class FilterGroupsTest < ApplicationSystemTestCase
  setup do
    @filter_group = filter_groups(:one)
  end

  test "visiting the index" do
    visit filter_groups_url
    assert_selector "h1", text: "Filter groups"
  end

  test "should create filter group" do
    visit filter_groups_url
    click_on "New filter group"

    fill_in "Odata request", with: @filter_group.odata_request_id
    click_on "Create Filter group"

    assert_text "Filter group was successfully created"
    click_on "Back"
  end

  test "should update Filter group" do
    visit filter_group_url(@filter_group)
    click_on "Edit this filter group", match: :first

    fill_in "Odata request", with: @filter_group.odata_request_id
    click_on "Update Filter group"

    assert_text "Filter group was successfully updated"
    click_on "Back"
  end

  test "should destroy Filter group" do
    visit filter_group_url(@filter_group)
    click_on "Destroy this filter group", match: :first

    assert_text "Filter group was successfully destroyed"
  end
end
