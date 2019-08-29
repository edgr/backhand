class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :custom_angle

  def custom_angle
    return :x => model.angle
  end
end
