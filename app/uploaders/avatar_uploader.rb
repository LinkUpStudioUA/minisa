# frozen_string_literal: true

class AvatarUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions
  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment
  plugin :delete_raw

  Attacher.validate do
    validate_max_size 1.megabyte, message: 'is too large (max is 1 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

  process(:store) do |io, _context|
    versions = { original: io } # retain original

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      versions[:thumb]  = pipeline.resize_to_limit!(300, 300)
    end
    versions # return the hash of processed files
  end
end
