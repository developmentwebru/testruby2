require "shrine"
require "shrine/storage/s3"

s3_options = { 
  bucket:            Rails.env.production? ? SiteConfig.aws_s3_bucket : SiteConfig.aws_s3_bucket_development,
  region:            SiteConfig.aws_s3_region,
  access_key_id:     SiteConfig.aws_s3_access_key_id,
  secret_access_key: SiteConfig.aws_s3_secret_access_key
}

Shrine.storages = { 
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary
  store: Shrine::Storage::S3.new(**s3_options)                   # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :determine_mime_type # determine and store the actual MIME type of the file analyzed from file content
Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  # Uppy will send the "filename" and "type" query parameters
  filename = request.params["filename"]
  type     = request.params["type"]

  {
    content_disposition:    ContentDisposition.inline(filename), # set download filename
    content_type:           type,                                # set content type
    content_length_range:   (10*1024)..(10*1024*1024)            # limit upload size from 10kb to 10 MB
  }
}
Shrine.plugin :remove_invalid
Shrine.plugin :validation_helpers
