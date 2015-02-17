require 'rails_helper'

RSpec.describe "Jigsaw" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(JigsawImageImporter.new.grab_image_url("www.test.com/_1", 3)).to eq("www.test.com/_3")
    end
end