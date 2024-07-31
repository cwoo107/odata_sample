class AddBuiltFilterToFilters < ActiveRecord::Migration[7.0]
  def change
    add_column :filters, :built_filter, :string
  end
end
