require 'rails_helper'

RSpec.describe "asos" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(AsosImageImporter.new.grab_larger_image("http://images.asos-media.com/inv/media/8/1/3/5/4195318/lilac/image1xl.jpg")).to eq("http://images.asos-media.com/inv/media/8/1/3/5/4195318/lilac/image1xxl.jpg")
      expect(AsosImageImporter.new.grab_larger_image_numb("http://images.asos-media.com/inv/media/8/1/3/5/4195318/lilac/image1xl.jpg", 2)).to eq("http://images.asos-media.com/inv/media/8/1/3/5/4195318/image2xxl.jpg")
      expect(AsosImageImporter.new.grab_larger_image_numb("http://images.asos-media.com/inv/media/8/1/3/5/4195318/black/image1xl.jpg", 4)).to eq("http://images.asos-media.com/inv/media/8/1/3/5/4195318/image4xxl.jpg")
    end
end