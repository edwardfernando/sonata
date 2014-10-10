# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['sonatask_avatar']


  version :medium do
    process :quality => 80
    process :resize_to_limit => [200, 200]
  end

  # version :standard do
  #   process :resize_to_fill => [128, 128, :north]
  # end
  #
  # version :thumbnail do
  #   resize_to_fit(50, 50)
  # end

end
