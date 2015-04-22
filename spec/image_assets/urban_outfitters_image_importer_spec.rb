require 'rails_helper'

RSpec.describe "urban_outfitters" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(UrbanOutfittersImageImporter.new.change_char_value("http://euimages.urbanoutfitters.com/is/image/UrbanOutfittersEU/5752468611234_001_b?$detailMain$", "e")).to eq("http://euimages.urbanoutfitters.com/is/image/UrbanOutfittersEU/5752468611234_001_e?$detailMain$")
    end
end