require 'rails_helper'

RSpec.describe "BB_Clothing" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(BrownBagImageImporter.new.grab_image_url("http://www.bbclothing.co.uk/images/products/multipics/fp6k3156143_1.jpg", 2)).to eq("http://www.bbclothing.co.uk/images/products/multipics/fp6k3156143_2.jpg")
    end
end