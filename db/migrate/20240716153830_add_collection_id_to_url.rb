class AddCollectionIdToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :collection_id, :bigint
  end
end
