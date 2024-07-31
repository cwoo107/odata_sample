class CreateSelectFields < ActiveRecord::Migration[7.0]
  def change
    create_table :select_fields do |t|
      t.string :field_name
      t.belongs_to :odata_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
