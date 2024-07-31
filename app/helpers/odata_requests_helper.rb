module OdataRequestsHelper

  def build_url(odata_request:)

    built_url = "#{odata_request.collection.url.url}#{odata_request.url}?$count=true"
    selects = "&$select="
    filters = "&$filter="

    if odata_request.select_fields.any?
      field_names = []
      select_fields = odata_request.select_fields
      select_fields.each do |select|
        field_names << select.field_name
      end
      selects += field_names.join(', ')
      built_url << "#{selects}"
    end

    # check for filter groups
    if odata_request.filter_groups.any?
      filter_groups_array = []
      # loop through filter groups
      odata_request.filter_groups.each do |filter_group|
        # check for filters
        if filter_group.filters.any?
          filter_group_string = ""

          # create empty filter group array
          filter_group_array = []
          # loop through filters to add to filter group array
          filter_group.filters.each do |filter|
            filter_group_array << "#{filter.filter_field} #{filter.operator} '#{filter.filter_value}'"
          end
          filter_group_string += filter_group_array.join(' and ')
          filter_groups_array << "(#{filter_group_string})"
        end
      end
      if filter_groups_array != [""]
        puts "the filter groups array is #{filter_groups_array}"
        filters += filter_groups_array.join(' or ')
        built_url << "#{filters}"
      end
    end
    built_url
  end
end
