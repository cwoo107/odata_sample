class SelectField < ApplicationRecord
  belongs_to :odata_request, touch: true
  broadcasts_refreshes

end
