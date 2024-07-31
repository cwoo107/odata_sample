class AddCollectionIdToCredentials < ActiveRecord::Migration[7.0]
  def change
    add_column :credentials, :collection_id, :bigint
  end
end
