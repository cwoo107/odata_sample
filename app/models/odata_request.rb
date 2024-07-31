class OdataRequest < ApplicationRecord
  belongs_to :collection, touch: true
  has_many :select_fields, dependent: :destroy
  has_many :filter_groups, dependent: :destroy
  broadcasts_refreshes

  before_create :build_on_request
  before_update :build_on_request
  after_touch :build_on_touch

  private

  def build_on_request
    build_url
  end

  def build_on_touch
    build_url
    self.save!
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

  def process_dates(value, time_zone = 'UTC')
    begin
      parsed_date = DateTime.strptime(value, "%m/%d/%Y")
      parsed_date_with_zone = parsed_date.in_time_zone(time_zone)
      return parsed_date_with_zone.strftime("%Y-%m-%dT%H:%M:%S.%6NZ")
    rescue ArgumentError, TypeError
      return "'#{value}'"
    end
  end
end
