json.extract! select_field, :id, :field_name, :odata_request_id, :created_at, :updated_at
json.url select_field_url(select_field, format: :json)
