class Filter < ApplicationRecord
  belongs_to :filter_group, touch: true
  before_save :build_filter

  def build_filter
    self.built_filter = "#{self.filter_field} #{self.operator} #{self.filter_value}"
  end

end
