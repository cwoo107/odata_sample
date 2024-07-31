json.extract! credential, :id, :user_id, :username, :password, :created_at, :updated_at
json.url credential_url(credential, format: :json)
