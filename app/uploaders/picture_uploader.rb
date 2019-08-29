class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :rotated_90 do
    eager
    cloudinary_transformation transformation: [
      { angle: 90 }
    ]
  end

  version :rotated_180 do
    eager
    cloudinary_transformation transformation: [
      { angle: 180 }
    ]
  end

  version :rotated_270 do
    eager
    cloudinary_transformation transformation: [
      { angle: 270 }
    ]
  end
end
