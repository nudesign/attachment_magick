AttachmentMagick.setup do |config|
  config.default_add_partial  = "layouts/attachment_magick/images/add_image"
  config.columns_amount       = 19
  config.columns_width        = 54
  config.gutter               = 3

  config.custom_styles do
    thumb      "36x36"
    fullscreen :width => 1024
    publisher "54x"
  end
end