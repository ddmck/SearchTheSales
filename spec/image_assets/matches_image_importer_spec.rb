require 'rails_helper'

RSpec.describe "matches_fashion" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(MatchesImageImporter.new.get_image_url("http://assets.matchesfashion.com/products/1003313000_1_zoom.jpg", 3)).to eq("http://assets.matchesfashion.com/products/1003313000_3_zoom.jpg")
    end
end