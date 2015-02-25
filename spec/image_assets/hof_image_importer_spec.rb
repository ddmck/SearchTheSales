require 'rails_helper'

RSpec.describe "House of Fraser" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(HOFImageImporter.new.grab_image_url("http://houseoffraser.scene7.com/is/image/HOF/I_196835834_00_20140827", 2)).to eq("http://houseoffraser.scene7.com/is/image/HOF/I_196835834_02_20140827")
    end
end