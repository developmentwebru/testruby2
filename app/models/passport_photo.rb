class PassportPhoto < ApplicationRecord
  include PassportPhotoUploader::Attachment(:image)
  belongs_to :profile

  validates :image, presence: true
end
