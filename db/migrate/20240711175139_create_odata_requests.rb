class CreateOdataRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :odata_requests do |t|
      t.belongs_to :collection, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :base_url
      t.string :url
      t.bigint :authorization

      t.timestamps
    end
  end
end
