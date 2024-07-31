class AddUserToOdataRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :odata_requests, :user, null: true, foreign_key: true
    OdataRequest.update_all(user_id: 1)
    change_column_null :odata_requests, :user_id, false

  end
end
