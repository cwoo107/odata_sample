require "test_helper"

class SelectFieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @select_field = select_fields(:one)
  end

  test "should get index" do
    get select_fields_url
    assert_response :success
  end

  test "should get new" do
    get new_select_field_url
    assert_response :success
  end

  test "should create select_field" do
    assert_difference("SelectField.count") do
      post select_fields_url, params: { select_field: { field_name: @select_field.field_name, odata_request_id: @select_field.odata_request_id } }
    end

    assert_redirected_to select_field_url(SelectField.last)
  end

  test "should show select_field" do
    get select_field_url(@select_field)
    assert_response :success
  end

  test "should get edit" do
    get edit_select_field_url(@select_field)
    assert_response :success
  end

  test "should update select_field" do
    patch select_field_url(@select_field), params: { select_field: { field_name: @select_field.field_name, odata_request_id: @select_field.odata_request_id } }
    assert_redirected_to select_field_url(@select_field)
  end

  test "should destroy select_field" do
    assert_difference("SelectField.count", -1) do
      delete select_field_url(@select_field)
    end

    assert_redirected_to select_fields_url
  end
end
