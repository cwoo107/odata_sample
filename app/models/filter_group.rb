class FilterGroup < ApplicationRecord
  belongs_to :odata_request, touch: true
  has_many :filters, dependent: :destroy
  broadcasts_refreshes

  after_touch :build_filter_group
  private
  def build_filter_group
    pp filters
    if filters.any?
      self.built_filter_group = ""
      filter_group_array = []
      filters.each do |filter|
        filter_group_array << filter.built_filter
      end
      self.built_filter_group += filter_group_array.join(' and ')
      self.save
    else
      self.built_filter_group = nil
      self.save
    end
    self.odata_request.touch
  end
end
