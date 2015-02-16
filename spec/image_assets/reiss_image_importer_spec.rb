require 'rails_helper'

RSpec.describe "Reiss" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(ReissImageImporter.new.get_image_url("http://img.reiss.co.uk/downloads/Image/product/87x100/514135-30-1.jpg", 3)).to eq("http://img.reiss.co.uk/downloads/Image/product/87x100/514135-30-3.jpg")
    end
end