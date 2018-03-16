class BannerUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  version :full do
    eager
    process resize_to_fill: [1500, 300, "center"]
  end
  
  def default_public_id
    ENV["BANNER_PLACEHOLDER_CLOUDINARY_ID"]
    # http://res.cloudinary.com/xxxx/image/upload/v1521091067/abcdefghijkl.jpg
    # public_id: abcdefghijkl
  end
  
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
