class Credential < ApplicationRecord
  belongs_to :user
  belongs_to :collection

  encrypts :password
end
