require 'test_helper'
 
class ImageTest < ActiveSupport::TestCase
  def test_image
    assert_kind_of AttachmentMagick::Image, AttachmentMagick::Image.new
  end
end