json.extract! filter, :id, :filter_group_id, :filter_field, :operator, :filter_value, :created_at, :updated_at
json.url filter_url(filter, format: :json)
