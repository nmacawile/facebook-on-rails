class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  version :full do
    eager
    process resize_to_fill: [400, 400, "face:auto"]
  end
  
  version :banner_display do
    eager
    process resize_to_fill: [200, 200, "face:auto"]
  end
  
   version :home_display do
    eager
    process resize_to_fill: [150, 150, "face:auto"]
  end
  
  version :post_thumb do
    eager
    process resize_to_fill: [50, 50, "face:auto"]
  end
  
  version :comment_thumb do
    eager
    process resize_to_fill: [32, 32, "face:auto"]
  end
  
  def default_public_id
    ENV["AVATAR_PLACEHOLDER_CLOUDINARY_ID"]
    # http://res.cloudinary.com/xxxx/image/upload/v1521091067/abcdefghijkl.jpg
    # public_id: abcdefghijkl
  end
  
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
