require 'test_helper'
require 'open-uri'

class AttachmentMagickTest < ActiveSupport::TestCase
  def test_has_attachment_magick
    grids = Artist.send(:generate_grids)

    Artist.attachment_magick do
      grid_1
      grid_5  "120x240"
      grid_7  :height => 200
      grid_10 :height => 200, :width => 100
    end

    assert_equal [:grid_1, :grid_5, :grid_7, :grid_10], order_array(Artist.attachment_magick_default_options[:styles].keys)

    assert_equal grids[:grid_1][:width],  Artist.attachment_magick_default_options[:styles][:grid_1][:width]
    assert_equal grids[:grid_1][:height], Artist.attachment_magick_default_options[:styles][:grid_1][:height]

    assert_equal 120,                     Artist.attachment_magick_default_options[:styles][:grid_5][:width]
    assert_equal 240,                     Artist.attachment_magick_default_options[:styles][:grid_5][:height]

    assert_equal grids[:grid_7][:width],  Artist.attachment_magick_default_options[:styles][:grid_7][:width]
    assert_equal 200,                     Artist.attachment_magick_default_options[:styles][:grid_7][:height]

    assert_equal 100,                     Artist.attachment_magick_default_options[:styles][:grid_10][:width]
    assert_equal 200,                     Artist.attachment_magick_default_options[:styles][:grid_10][:height]
  end
  
  #FIXME Valores das variáveis devem ser aleatórios
  def test_generate_grids
    column_width  = 29
    column_amount = 10
    gutter        = 3
    
    grid_system = open("http://www.spry-soft.com/grids/grid/?column_width=#{column_width}&column_amount=#{column_amount}&gutter_width=#{gutter}") { |url| Hpricot(url) }
    grids       = Artist.send(:generate_grids, column_amount, column_width, gutter)
    
    assert_equal grids.size, column_amount
    
    grids.keys.each do |key|
      assert_equal grids[key][:width],  grid_system.search(".#{key} p").first.inner_html.gsub(/\D/, "").to_i
    end  
  end
  
  private

  def order_array(array)
    array.sort{|x, y| x.to_s.split("_")[1].to_i <=> y.to_s.split("_")[1].to_i}
  end
end