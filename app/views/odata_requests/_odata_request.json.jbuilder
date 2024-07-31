json.extract! odata_request, :id, :collection_id, :name, :description, :base_url, :url, :authorization, :created_at, :updated_at
json.url odata_request_url(odata_request, format: :json)
