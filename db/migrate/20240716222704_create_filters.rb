class CreateFilters < ActiveRecord::Migration[7.0]
  def change
    create_table :filters do |t|
      t.belongs_to :filter_group, null: false, foreign_key: true
      t.string :filter_field
      t.string :operator
      t.string :filter_value

      t.timestamps
    end
  end
end
