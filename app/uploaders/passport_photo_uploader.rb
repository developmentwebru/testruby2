class PassportPhotoUploader < Shrine
  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png]
    validate_size (10*1024)..(10*1024*1024) # between 10kb and 10mb
  end
end
