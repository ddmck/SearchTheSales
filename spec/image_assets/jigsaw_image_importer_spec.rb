require 'rails_helper'

RSpec.describe "Jigsaw" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(JigsawImageImporter.new.grab_image_url("www.test.com/_1")).to eq("www.test.com/_2")
    end
end