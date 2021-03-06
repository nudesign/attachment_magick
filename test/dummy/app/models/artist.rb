class Artist
  include Mongoid::Document
  include AttachmentMagick

  field :name
  field :lastname
  embeds_many :works

  validates_presence_of :name, :lastname

  attachment_magick do
    grid_1
    grid_10 :width => 150
    grid_15 "200x300"
    grid_16 :height => 230
    thumb   :crop => false
    fullscreen
    publisher
  end
end
