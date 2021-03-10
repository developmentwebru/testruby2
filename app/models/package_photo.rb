class PackagePhoto < ApplicationRecord
  include PackagePhotoUploader::Attachment(:image)
  belongs_to :package, touch: true

  validates :image, presence: true
end
