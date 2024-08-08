class OdataRequest < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :collection, touch: true
  has_many :select_fields, dependent: :destroy
  has_many :filter_groups, dependent: :destroy
  has_many :filters, through: :filter_groups, dependent: :destroy
  after_update_commit -> { broadcast_replace_to("odata_request_#{self.id}") }

  before_create :build_url
  before_update :build_url
  after_touch :build_on_touch

  private
  def build_on_touch
    self.update!(updated_at: DateTime.now)
  end

  def build_url
    built_url = "#{self.collection.url.url}#{self.url}?"
    selects = ""
    filters = ""
    if self.select_fields.any?
      field_names = []
      select_fields = self.select_fields
      select_fields.each do |select|
        field_names << select.field_name
      end
      selects += field_names.join(', ')
      puts "Selects are #{selects}"
      selects = selects.to_s
      built_url << "&$select=#{URI.encode_www_form_component(selects)}"
    end
    # check for filter groups
    filter_groups_array = []
    if self.filter_groups.any?
      # loop through filter groups
      self.filter_groups.each do |filter_group|
        # check for filters
        if filter_group.built_filter_group.nil?
          filter_group.built_filter_group = ""
        end
        filter_groups_array << "(#{filter_group.built_filter_group})"
      end
    end
    if filter_groups_array != []
      puts "the filter groups array is #{filter_groups_array}"
      filters += filter_groups_array.join(' or ')
      built_url << "&$filter=#{URI.encode_www_form_component(filters)}"
    end
    self.base_url = built_url + "&$count=true"
  end

end
