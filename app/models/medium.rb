# == Schema Information
#
# Table name: media
#
#  id               :integer          not null, primary key
#  name             :string
#  internal_name    :string
#  description      :text
#  popularity_order :integer
#  medium_kind      :string
#  video_link       :string
#  small_image      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Medium < ApplicationRecord
  include SmallImageable

  validates :name, presence: true

  def small_image_wrapper_video
    if !self.small_image_url.nil?
      return self.small_image_url
    else
      return 'http://img.phonandroid.com/2016/02/telecharger-video-youtube-hors-ligne.jpg'
    end
  end

  # Creation of image attachments for text editor summernote
  def self.create_image_attachment(image_params)
    random_name = "ImageAttachment" + (Medium.maximum(:id).next || 1).to_s
    medium = self.create(name: random_name, small_image: image_params, medium_kind: "Image")
    return medium
  end

end
