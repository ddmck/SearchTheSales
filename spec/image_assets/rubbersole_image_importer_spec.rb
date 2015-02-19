require 'rails_helper'

RSpec.describe "Rubbersole" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(RubbersoleImageImporter.new.get_image_url("http://photos6.rubbersole.co.uk/photos/513/513634/513634_350_A.jpg", "B")).to eq("http://photos6.rubbersole.co.uk/photos/513/513634/513634_350_B.jpg")
    end
end