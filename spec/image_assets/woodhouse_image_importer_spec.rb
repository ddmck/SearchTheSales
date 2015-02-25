require 'rails_helper'

RSpec.describe "woodhouse" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(WoodhouseImageImporter.new.get_image_url("http://images.asos-media.com/inv/media/8/1/3/5/4195318/lilac/_1.jpg", 3)).to eq("http://images.asos-media.com/inv/media/8/1/3/5/4195318/lilac/_3.jpg")
    end
end