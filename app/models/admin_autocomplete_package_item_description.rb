class AdminAutocompletePackageItemDescription < ApplicationRecord
  validates :value, presence: true, uniqueness: true
end
