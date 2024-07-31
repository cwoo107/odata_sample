require "application_system_test_case"

class SelectFieldsTest < ApplicationSystemTestCase
  setup do
    @select_field = select_fields(:one)
  end

  test "visiting the index" do
    visit select_fields_url
    assert_selector "h1", text: "Select fields"
  end

  test "should create select field" do
    visit select_fields_url
    click_on "New select field"

    fill_in "Field name", with: @select_field.field_name
    fill_in "Odata request", with: @select_field.odata_request_id
    click_on "Create Select field"

    assert_text "Select field was successfully created"
    click_on "Back"
  end

  test "should update Select field" do
    visit select_field_url(@select_field)
    click_on "Edit this select field", match: :first

    fill_in "Field name", with: @select_field.field_name
    fill_in "Odata request", with: @select_field.odata_request_id
    click_on "Update Select field"

    assert_text "Select field was successfully updated"
    click_on "Back"
  end

  test "should destroy Select field" do
    visit select_field_url(@select_field)
    click_on "Destroy this select field", match: :first

    assert_text "Select field was successfully destroyed"
  end
end
