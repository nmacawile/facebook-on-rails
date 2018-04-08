class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  version :preview do
    eager
    process resize_to_limit: [570]
  end
  
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
