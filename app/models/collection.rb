class Collection < ApplicationRecord
  belongs_to :user
  has_many :odata_requests, dependent: :destroy
  has_one :url
  has_one :credential

  broadcasts_refreshes
end
