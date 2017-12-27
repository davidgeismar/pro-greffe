
module SmallImageable
  extend ActiveSupport::Concern

  # Module that is added to all the class that need an alert system reporting errors.
  # Add an alerts has_many associations
  included do
    mount_uploader :small_image , SmallImageUploader
  end

  # Method to declare that the model is small_imageable
  def is_small_imageable?
    return true
  end


  module ClassMethods

  end
end
