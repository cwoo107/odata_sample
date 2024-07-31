class CreateFilterGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :filter_groups do |t|
      t.belongs_to :odata_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
