
class VideoUploader < Shrine
  plugin :cached_attachment_data
  plugin :remove_attachment
  plugin :delete_raw
  plugin :cached_attachment_data

  Attacher.validate do
    validate_max_size 120.megabyte, message: 'is too large (max is 120 MB)'
  end
end
