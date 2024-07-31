class AddBuiltFilterGroupToFilterGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :filter_groups, :built_filter_group, :string
  end
end
